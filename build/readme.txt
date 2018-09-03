package.nuspec is the center of universe.


Attributes mapping:
|   package.nuspec   |   ProductInfo.cs        |
------------------------------------------------
|     id             |  ?package name?         |
|     version        |  AssemblyVersion        |
|     version        |  AssemblyFileVersion    |
|     title          |  AssemblyProduct        |
|     authors        |  -------                |
|     owners         |  AssemblyCompany        |
|     .......        |                         |
|     copyright      |  AssemblyCopyright      |
|     ------         |  AssemblyTrademark      |


Add project to CC.NET by adding this line to conf/projects.xml in ccnet environment:
    <cb:project_def ProjectName="CapabilitiesService" ProjectBranch="default" RepoProjectName="CapabilitiesService_latest/trunk" InitialBuildNumber="10"/>

Global definitions for project_def macro:
    <cb:define WDir="$(BaseDir)\work_dirs\$(ProjectName)_$(ProjectBranch)" />
    <cb:define ADir="$(BaseDir)\artifacts\$(ProjectName)_$(ProjectBranch)" />


CC.NET for it project name will use: $(ProjectName)_$(ProjectBranch)

CC.NET project:
                name: $(ProjectName)_$(ProjectBranch)
                working directory: $(WDir)
                artifact Directory: $(ADir)

Repository:
            Working directory set by CC.NET: $(WDir)
            Repository location: $(ReposBasePath)/$(RepoProjectName)/
            Branch: $(ProjectBranch)

Labelling:
          <labelPrefixFile>$(WDir)\build\package.nuspec</labelPrefixFile>
          <labelPrefixFileSearchPattern>(?&lt;=&lt;version&gt;)\d+\.\d+\.\d+\.</labelPrefixFileSearchPattern>

MSBuild working directory: $(WDir)\build\
        project file: $(WDir)\build\
        build args: /p:Configuration=Release;Platform=AnyCpu /m
        targets: BuildPackage

Build publisher
                source directory: build\pkg

Package publisher
                  package name: $(ProjectName)_$(ProjectBranch)
                  source directory: build\out




--------------------------------------------------------------------


Environment enforcements:
 - build\package.nuspec - package descriptor. It does not have to nuget package (sic!)
 - (?<=<version>)\d+\.\d+\.\d+\. - regular expression to get 3 numbered version from build/package.nuspec
 - build\ - working directory for MSBuild execution
 - build\build.msbuild - msbuild script
 - /p:Configuration=Release;Platform=AnyCpu /m - msbuild execution parameters
 - build\pkg - directory contains all the files to be copied as build artifacts
 - build\our - directory that contains all the files to be packaged as zip and published as result package 

 - solution file in src/ directory







MAVEN
------



    <!-- Nuspec:  <id>Intergraph.Geospatial.Portal.BuildUtilities</id> -->
    <!-- Nuspec:  <version>14.0.0-SNAPSHOT</version> -->
    <groupId>Intergraph.Geospatial.Portal</groupId>
    <artifactId>build-utilities</artifactId>
    <version>14.0.0-SNAPSHOT</version>
    <packaging>pom</packaging>

    <parent>
      <groupId>Intergraph.Geospatial.Portal</groupId>
      <artifactId>common-pom</artifactId>
      <version>14.0.0</version>
      <relativePath>parent-pom.xml</relativePath>
    </parent>

    <!-- Nuspec:  <title>Portal Build Utilities</title> -->
    <name>Portal Build Utilities</name>

    <!-- Nuspec:  <description>_description_</description> -->
    <description>_description_</description>


    <url>http://geospatial.intergraph.com</url>


    <!-- Nuspec:  <authors>Intergraph Corporation</authors> -->
    <!-- Nuspec:  <owners>Intergraph Corporation</owners> -->
    <!-- Nuspec:  <copyright>Copyright Intergraph Corporation 2012</copyright> -->
    <organization>
      <name>Intergraph Corporation</name>
      <url>http://www.intergraph.com</url>
    </organization>

    <!-- Nuspec:  <requireLicenseAcceptance>false</requireLicenseAcceptance> -->
    <!-- Nuspec:  <releaseNotes>Summary of changes made in this release of the package. TODO</releaseNotes> -->
    <!-- Nuspec:  <tags>CapabilitiesService Portal</tags> -->


