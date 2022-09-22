# Details DevOps Repo

BASED ON 

This repository holds the Devops Resources, it holds the yaml files for the pipelines in the [Dev Ops Pipelines Section](https://dev.azure.com/OrgNameProjNS/Sample_Rackspace/_build)

More Information about yaml based pipelines can be found on the [Microsoft Site](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema%2Cparameter-schema
) 

**Table of Contents**
[[_TOC_]] 

## Repo File Structure 

The way this Repo us organized is that Pipeline yaml files are grouped by Project in to folders, for instance the API Pipelines and grouped in to the folders: 

.\Sample-API-Pipelines
.\Sample-Core-Pipelines

Within the Folder the Pipeline files are grouped by the Pipeline type for instance a Folder named CI for Continues Integration or named Release, each Pipeline has a yaml file that holds the tasks of the pipeline as well as templates to make common tasks reusable between the pipelines.

The yaml Pipeline files have the file extension *.pipeline.yml and the templates *.template.yml to make it easier to differentiate between them.

The Templates will in the lowest folder of which they are shared with so for example a template used by the CI and Release Pipeline of the API will be within the API folder while a template used by the API and Core Project will be at the root in a folder called .\SharedResources

- Sample-API-Pipelines
	- CI
		- Sample-API_CI.pipeline.yml
	- Release
		- Sample-API_Release.pipeline.yml
- Sample-Core-Pipelines
	- CI
		- Sample-Core_CI.pipeline.yml
	- Release
		- Sample-Core_Release.pipeline.yml
	- SharedResources
		- NodeAndGulpTasks.Template.yml
- SharedResources
	- GenerateVersionString.Template.yml
	- PackageRestore.Template.yml
	


## Documentation Standards and Auto Generated Content

This Documentation is Generated by the ./RegenerateReadMe.ps1 Powershell Script.
In order to have the Documentation regenareated after each commit, copy the "pre-commit(copy me in to Git-Hooks folder)" file in to the git/hooks folder and rename it to "pre-commit"
This will let the git client that you are using know to execute the ./RegenerateReadMe.ps1 file, hence regenerate the documentation

It is composed of the content of the __Readme.md file as well as a list, the script Generates, of all Yaml Pipeline and Template Files.

The List of all the Yaml Pipeline and template files contains details of the purpose and useful information like Parameters needed for each of the Templates listed.

Each Pipeline and template contains xml tags with a summery of the files purpose and useful Information like:
- Details on the purpose of the File
- Templates used in the Pipeline
- Parameters used for Templates
- and other useful information

The Script gets the Information from xml tags in the Pipeline files

for example the the summary and remarks tags from the release pipeline 

*<summary>
 This is the Release Pipeline definition file for the Sample-API Project
 Its triggered when a new release branch is created or an existing release branch updated
 </summary>*

*<remarks>
 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables
</remarks>*



---




---
# Pipeline files


## Sample-API_CI.pipeline.yml

### summary

 This is the Continuous Integration (CI) Pipeline definition file for the Sample-API Project
 Its triggered to run when changes are merged in to the master branch
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### ToDo

 One of the unit tests fails, once the Sample repo's are updated from the current enable workspace check if it still fails 
 and if so investigate 

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- RunUnitTests
- Build-Pack-NetSDKStyle


## Sample-API_Release.pipeline.yml

### summary

 This is the Release Pipeline definition file for the Sample-API Project
 Its triggered when a new release branch is created or an existing release branch updated
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- Build-Pack-NetSDKStyle


## Sample-Core_CI.pipeline.yml

### summary

 This is the Continuous Integration (CI) Pipeline definition file for the Sample-API Project
 Its triggered to run when changes are merged in to the master branch
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- Build-Pack-LegacyStyle
- RunUnitTests


## Sample-Core_Release.pipeline.yml

### summary

 This is the Release Pipeline definition file for the Sample-Core Project
 Its triggered when a new release branch is created or an existing release branch updated
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- Build-Pack-LegacyStyle


## Sample-Services_Translation_Build_Release.pipeline.yml

### summary

 This is the Build and Release Pipeline file for the Sample Service apps and functions
 It will deploy directly to the relevant Azure resource
 Each environment has its on stage
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables
 
 Each environment has a variable group in the DevOps library, see https://dev.azure.com/OrgNameProjNS/Sample/_library?itemType=VariableGroups
 the variable groups are mapped to the Stage(Dev, QA, Prod) to get the corresponding settings for each environment

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- Build
- RunUnitTests
- PublishFunctionApp
- SetFunctionAppSettings
- PublishFunctionApp
- SetFunctionAppSettings
- PublishFunctionApp
- SetFunctionAppSettings
- PublishFunctionApp
- SetFunctionAppSettings


## Sample-Shared.pipeline.yml

### summary

 To share and reuse code between the solutions we use the Sample-Shared pipeline to pack the shared code into NuGet Packages. The generated packages can then be consumed from multiple solutions and projects.
 For example, the Sample Core Solution has the code to access the Database and the Sample API Solution reuses this code.
 In order to make the shared code available as NuGet Packages, the Sample-Shared Pipeline builds and publishes the shared code. As an example, we run the following steps in the Pipeline for the DataAccess Project.
 1. Build the DataAccess Project
 2. Package it as a NuGet Package
 3. Upload it to a shared artifact feed
 4. Add the NuGet package with a reference to the Sample API Solution’s Web Project
 
### remarks

 This Pipeline file uses Variables and parameters,
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### ToDo

 In order for Debug Symbols and sourceLink info to work the project files need to be migrated
 to the new project file layout, please follow the instructions in ticket 2943 / confluence
 reenable code on line 44 and 134

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- Build-Pack-LegacyStyle
- Build-Pack-NetSDKStyle
- IndexAndPublishSymbols


## Sample-SupportTool_CI.pipeline.yml

### summary

 This is the CI Pipeline definition file for the Sample-SupportTool Project
 Its triggered when the Master branch gets updated
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- RunUnitTests
- Build-Pack-LegacyStyle


## Sample-SupportTool_Release.pipeline.yml

### summary

 This is the Release Pipeline definition file for the Sample-SupportTool Project
 Its triggered when a new release branch is created or an existing release branch updated
 
### remarks

 This Pipeline file uses Variables and parameters, 
 the parameters are used because they allow for objects with multiple properties to be defined
 this cannot be done using variables

### Templates Used by Pipeline
- GenerateVersionString
- SetBuildName
- PackageRestore
- Build-Pack-LegacyStyle
---
# Pipeline Template files


## SetFunctionAppSettings.Template.yml

### summary

 This Template will apply the settings to the pipeline function app
 
### remarks

 There are no Parameters passed in, the template uses Variables that have been defined in a variable group within the DevOps library, 
 see https://dev.azure.com/OrgName/Sample/_library?itemType=VariableGroups
 the variable groups are mapped to the Stage(Dev, QA, Prod) calling the template and is then accessible from this Template

 This is done so we dont have to map each setting to a parameter in the pipeline 

### Param

 instead of parameters this template uses Variables defined in the parent pipeline
 each environment has a variable group in the DevOps library, see https://dev.azure.com/OrgName/Sample/_library?itemType=VariableGroups
 the variable groups are mapped to the Stage(Dev, QA, Prod) calling the template and is then accessible from this Template 

### Template is used by:
- Sample-Services_Translation_Build_Release.pipeline.yml


## IndexAndPublishSymbols.Template.yml

### summary

 This Template indexes and publish the debug symbols to DevOps teamServices, 
 when a project has the sourcemap NuGet package installed, you can setup with the Debugger in to the 
 project even if it is added as a Package
 see https://docs.microsoft.com/en-us/azure/devops/pipelines/artifacts/symbols?view=azure-devops 
 for more details
 
### param

 **packVer** Set this version to the same as the NuGet package on the feed so that VisualStudio 
 can load the correct debug symbols from  DevOps teamServices
 **projects** An object list of all the project that you want to publish the debug symbols for

### Template is used by:
- Sample-Shared.pipeline.yml


## Build.Template.yml

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-API_Release.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Core_Release.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-Shared.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml
- Sample-SupportTool_Release.pipeline.yml


## PackageRestore.Template.yml

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-API_Release.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Core_Release.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-Shared.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml
- Sample-SupportTool_Release.pipeline.yml


## RunUnitTests.Template.yml

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml


## Build-Pack-LegacyStyle.Template.yml

### summary

 This Template will build and package projects that are based on the old project file layout, 
 you can recognize the projects by the Properties and References section instead of the new style dependency section 
 It includes the tasks to build the project, run the gulp tasks for scss and js and package it all in to a NuGet file
 
### param

 **packVer** This parameter is to hold the Version String used for the NuGet package 
 **projects**
 To hold a List of objects for each Project to be build and packaged in the format:
  
  - { Name: 'Web', NameSpace: '', PackageNS: 'OrgName.Sample-Core', IsWebProj: true, Precompile: true ,SourceDir: 'Source\Web' }
  - { Name: 'BackgroundProcessing', NameSpace: '', PackageNS: 'OrgName.Sample-Core' }

 Where IsWebProj will copy js and css files to the package, SourceDir is used as root for the copying of the css and js files
 NameSpace is referring to the Project namespace for example InfoExchange2.{ProjectName} 
 while PackageNS is for the NuGet package and can be for example Sample.{ProjectName}
 **PackageDescription**  With this parameter the NuGet Package Description can be customized, 
 the description shows in the NuGet feed and package manager
 RunGulp parameter property is to install npm and run the gulp tasks

GulpTasks a string list of the gulp tasks to run
### param

 **packVer** This parameter is to hold the Version String used for the NuGet package 
 **projects**
 To hold a List of objects for each Project to be build and packaged in the format:
  
  - { Name: 'Web', NameSpace: '', PackageNS: 'OrgName.Sample-Core', IsWebProj: true, Precompile: true ,SourceDir: 'Source\Web' }
  - { Name: 'BackgroundProcessing', NameSpace: '', PackageNS: 'OrgName.Sample-Core' }

 Where IsWebProj will copy js and css files to the package, SourceDir is used as root for the copying of the css and js files
 NameSpace is referring to the Project namespace for example InfoExchange2.{ProjectName} 
 while PackageNS is for the NuGet package and can be for example Sample.{ProjectName}
 **PackageDescription**  With this parameter the NuGet Package Description can be customized, 
 the description shows in the NuGet feed and package manager
 RunGulp parameter property is to install npm and run the gulp tasks

GulpTasks a string list of the gulp tasks to run
### remarks


### Template is used by:
- Sample-Core_CI.pipeline.yml
- Sample-Core_Release.pipeline.yml
- Sample-Shared.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml
- Sample-SupportTool_Release.pipeline.yml


## Build-Pack-NetSDKStyle.Template.yml

### summary

 This Template will build and package projects that are based on the newer .net sdk project file layout, 
 you can recognize the projects by having the the dependency section instead of the old style Properties and References section 
 It includes the tasks to build the project and package it all in to a nuget file.
 
### remarks

 This template dos not have the gulp tasks and other steps for web projects 
 because the projects we have at the time this template was written had no need for it
 if it becomes a requirement in the future the tasks can be copied from the Build-Pack-LegacyStyle.Template.yml

 This template allows for Packages to be build in the nuget standard using the dotnet/msbuild /pack parameter
but alternatively Octopack can be used, by setting the UseOctoPack template parameter to true or false

### param

 **packVer** This parameter is to hold the Version String used for the NuGet package 
 **projects**
 To hold a List of objects for each Project to be build and packaged in the format:
- { Name: 'Web.Api', NameSpace: '', PackageNS: 'OrgName.Sample-API' }
- { Name: 'BackgroundProcessing', PackageNS: 'OrgName.Sample-API', NameSpace: '' }
 **PackageDescription**  With this parameter the Nuget Package Description can be customized, 
 the description shows in the NuGet feed and packagemanager
 **UseOctoPack set to false To use dotnet sdk for packing or true to use Octopack**

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-API_Release.pipeline.yml
- Sample-Shared.pipeline.yml


## GenerateVersionString.Template.yml

### summary

 This Template will Populate the Version string, 
 for none CI pipelines it will version in the Format:
 Year.Month.Day.RunCounter-BranchName 
 so for example bugfix/3453_test-branch will result in version 2021.7.23.2-bugfix-3453-test-branch 
 If the parameter is set to true the branch name will always be set to master
 
### remarks

 This template requires a variable called $PackVer to be defined as empty string 
 in the Parent Pipeline 
 $PackVer will be populated with the Version String once this template executed 

### param

 **isCIPipeline** this parameter is set depending on if the pipeline is a CI or Release pipeline 

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-API_Release.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Core_Release.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-Shared.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml
- Sample-SupportTool_Release.pipeline.yml


## PackageRestore.Template.yml

### summary

 This Template will Restore Nuget packages, depending if the project is in the older style
 with the Properties and References section or the new style dependency section 
 the parameter PackageRefProjs must be correctly set
 
### param

 **restoreSolution** parameter can be the Solution name 
 or if there is only one Solution in the Repo left with its default value
 **nugetConfigPath** Path to the nugetConfig defaults to finding the nuget.config in the repo
 **PackageRefProjs** Depending if the project is in the older style
 with the Properties and References section or the new style dependency section 
 the parameter PackageRefProjs must be correctly set to true or false

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-API_Release.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Core_Release.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-Shared.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml
- Sample-SupportTool_Release.pipeline.yml


## PublishFunctionApp.Template.yml

### Template is used by:
- Sample-Services_Translation_Build_Release.pipeline.yml


## PublishWebApp.Template.yml

### Template is used by:


## RunUnitTests.Template.yml

### summary

 This Template will first build and then run the unit tests
 for the projects that are passed to the template as object parameter
 
### Param

 The object parameter projects expects the format
 - {  ProjectFileName: 'JsonApiSerialization.Tests', DisplayName: JsonApiSerialization } 
 - {  ProjectFileName: 'Enable.Testing.Infrastructure', DisplayName: Infrastructure }

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml


## SetBuildName.Template.yml

### summary

 This Template will rename the build so that is not based on the commit id
 of the DevOps Repo 
 
### remarks

 unfortunately the commit message from the code repo cannot be pulled, see; 
 https://stackoverflow.com/questions/62156628/azure-pipelines-multi-repo-how-to-get-git-commit-id 

### param

 This is the value for the new BuildName, by default the 

### Template is used by:
- Sample-API_CI.pipeline.yml
- Sample-API_Release.pipeline.yml
- Sample-Core_CI.pipeline.yml
- Sample-Core_Release.pipeline.yml
- Sample-Services_Translation_Build_Release.pipeline.yml
- Sample-Shared.pipeline.yml
- Sample-SupportTool_CI.pipeline.yml
- Sample-SupportTool_Release.pipeline.yml


## SetTimeZone.Template.yml

### summary

 This Template will update the Timezone settings of the Build Agent
 
### param

AgentTimeZone, set the correct timezone, run Get-TimeZone in PS to see the available timezones

### remarks


### Template is used by: