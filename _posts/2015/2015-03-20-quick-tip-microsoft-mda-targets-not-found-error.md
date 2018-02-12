---
title: 'Microsoft.MDA.targets Not Found Error'
excerpt: 'Quick tip for getting around "The imported project Microsoft.MDA.targets was not found"'
tags:
  - Cordova
  - Visual Studio
  - Visual Studio 2013
  - Visual Studio 2015
  - Visual Studio Tools for Apache Cordova
---

I've been doing a lot more work with Apache Cordova projects, specifically  I've been working on projects using the Visual Studio Tools for Apache Cordova `<insert your favorite joke about Microsoft product naming>`. I've been a Cordova/Phonegap fan since the beginning but marrying it to the Visual Studio debugging experience has taken the awesomeness to a new level.

The other day however I ran into an odd error opening a project. Rather than the expected joy, I got this error:

> The imported project "`C:Program Files (x86)MSBuildMicrosoftVisualStudiov14.0CordovaToolsvs-mda-targetsMicrosoft.MDA.targets`" was not found. Confirm that the path in the `<Import>`; declaration is correct, and that the file exists on disk.

This was not awesomeness at all.

The problem turns out to be a slight difference in paths between the 2013 and 2015 edition of the Tools for Cordova. In 2013 they are stored in the folder `%ProgramFiles(x86)/%MSBuild/Microsoft/Visual Studio/v12.0/CordovaTools`. In 2015 they are installed in `%ProgramFiles(x86)%/MSBuild/Microsoft/VisualStudio/v14.0/ApacheCordovaTools`.

Since this path is stored within the project file, moving between 2013 and 2015 results in an error. To move from one version to another you'll need to manually edit the `.jsproj` file and swap the following lines:

### Visual Studio 2013

```xml
<Import Project="$(MSBuildExtensionsPath32)MicrosoftVisualStudiov$(VisualStudioVersion)CordovaToolsvs-mda-targetsMicrosoft.MDA.targets" />
<Import Project="$(MSBuildExtensionsPath32)MicrosoftVisualStudiov$(VisualStudioVersion)CordovaToolsvs-mda-targetsMicrosoft.TypeScript.MDA.targets" />
```

### Visual Studio 2015

```xml
<Import Project="$(MSBuildExtensionsPath32)MicrosoftVisualStudiov$(VisualStudioVersion)ApacheCordovaToolsvs-mda-targetsMicrosoft.MDA.targets" />
<Import Project="$(MSBuildExtensionsPath32)MicrosoftVisualStudiov$(VisualStudioVersion)ApacheCordovaToolsvs-mda-targetsMicrosoft.TypeScript.MDA.targets" />
```
