<# This Script will generate and refresh the Readme.md file, see the Readme.md for more details on this#>

$root = "./"
$readmeFile = "README.md"
$baseReadMeFile = "__README.MD"

$Pipelines = (ls "$root*pipeline.yml" -r).FullName  | % {if((get-item "$_").psiscontainer){"$_\"}else{$_}}
$Templates = (ls "$root*template.yml" -r).FullName  | % {if((get-item "$_").psiscontainer){"$_\"}else{$_}}


function GetStringBetweenTwoStrings($firstString, $secondString, $importPath){
  
    $result = Get-Content $importPath | Out-String | % {[Regex]::Matches($_, "(?<=$firstString)((.|\n)*?)(?=$secondString)")} | % {$_.Value}
    return $result
}

function ListFileDetailsWithTags($FileList, $IsPipeLineFile){
 Write-Host "In Function ListFileDetailsWithTags with param: $FileList : $IsPipeLineFile "
 Foreach ($file in $FileList)
    {
        $pipeName = $file -replace '.*\\'

        Add-Content "$root$readmeFile" ""      
        Add-Content "$root$readmeFile" ""
        Add-Content "$root$readmeFile" "## $pipeName"
        Add-Content "$root$readmeFile" ""

        $XmlTagsInFiles = GetStringBetweenTwoStrings -firstString "</" -secondString ">" -importPath "$file"
        $XmlTagsInFiles 
        
    
        Foreach ($tag in $XmlTagsInFiles)
        {
            Add-Content "$root$readmeFile" "### $tag"
            $file
            $tagContent = GetStringBetweenTwoStrings -firstString "<$tag>" -secondString "</$tag>" -importPath $file
            $tagContent = $tagContent -replace '#', ''
            Add-Content "$root$readmeFile" $tagContent 
            
        }
        
        Write-Host "Is PipelineFile: $IsPipeLineFile"
        If ($IsPipeLineFile -eq 'true')
        {
               Write-Host "In Is Pipeline true block"

            $TemplatesUsed = GetStringBetweenTwoStrings -firstString "- template:" -secondString ".Template.yml" -importPath $file
            $file = $file -replace '.*\\'

            Add-Content "$root$readmeFile" "### Templates Used by Pipeline"

            $file
            Foreach ($temp in $TemplatesUsed)
            {
                $tempName  = $temp -replace '.*\\' 
                Add-Content "$root$readmeFile" "- $tempName"
            }
        }
        else
        {
            Add-Content "$root$readmeFile" "### Template is used by:"
            
            foreach ($pipe in $Pipelines) 
            {        
                $TemplatesUsed = GetStringBetweenTwoStrings -firstString "- template:" -secondString ".Template.yml" -importPath $pipe
                $pipe = $pipe -replace '.*\\'
              
              
                $pipeName = $pipeName -replace '.template.yml',''

                Write-Host "checking if template $pipeName is in $TemplatesUsed"
                if($TemplatesUsed -Match "$pipeName") {
                    Write-Host "yes  $pipeName is in $TemplatesUsed"
                    $pipee = $pipe -replace '.*\\'
                     Add-Content "$root$readmeFile" "- $pipe"
                } 
            }
    
        }
        
    }
}


$baseText = Get-Content -path "$root$baseReadMeFile"
Set-Content -path "$root$readMeFile" $baseText

Add-Content "$root$readmeFile" "---"
Add-Content "$root$readmeFile" "# Pipeline files"
ListFileDetailsWithTags -FileList $Pipelines -IsPipeLineFile true
Add-Content "$root$readmeFile" "---"
Add-Content "$root$readmeFile" "# Pipeline Template files"
ListFileDetailsWithTags -FileList $Templates -IsPipeLineFile false

