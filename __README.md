# Details DevOps Repo

BASED ON the concepts descriped in:
[multi repo approch](https://medium.com/@mr.david.mueller/yaml-pipelines-with-in-its-own-devops-repository-multiple-repositories-a7a5c80e9987)

[DevOps Repo Standarts](https://medium.com/@mr.david.mueller/automation-documentation-and-best-practices-for-your-devops-yaml-pipelines-using-githooks-and-b8dfa078bfc1)




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




