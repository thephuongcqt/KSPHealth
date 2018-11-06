# Table Of Content
1. [Requirements](#markdown-header-requirements)
2. [Architecture](#markdown-header-architecture)
 	* [Model-View-Controller (MVC)](#markdown-header-mvc)
    * [Model-View-ViewModel (MVVM)](#markdown-header-mvvm)
    * [Project Structure](#markdown-header-project-structure)
3. [Code Quality](#markdown-header-code-quality)
    * [Coding Convention](#markdown-header-coding-convention)
    * [Git Convention](#markdown-header-git-convention)
4. [Environment and build](#markdown-header-environment-build-apk)
    * [Build Dev](#markdown-header-build-dev)
    * [Build Staging](#markdown-header-build-staging)
    * [Build Product](#markdown-header-build-product)
5. [Libraries and tools included](#markdown-header-libraries-and-tools)


## <a name="markdown-header-requirements"></a>Requirements
* [XCode 10 or later](https://developer.android.com/studio/)
* [Swift 4.2](https://developer.android.com/kotlin/)
* [App Provisioning](https://developer.apple.com/support/code-signing/): 
	* Contact project leader in order to get development & distribute provisioning; certificate file.
* iOS 9.0+ 

## <a name="markdown-header-architecture"></a>Architecture
### <a name="markdown-header-mvc"></a>Model-View-controller (MVC)
This project follows by iOS architecture guidelines that based on [MVC](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html).
### <a name="markdown-header-mvvm"></a>Model-View-ViewModel (MVVM)


<img src="https://d23g4mi0z7gexh.cloudfront.net/assets/figure-model-view-view-model-swift-1-4d30d3cb6fb4eb62da23e84af7699bfd4ca10ed816041e25e1c8aa8987bb6089.jpg" alt=""/>

* Examples: 
	* https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm
	* https://www.appcoda.com/mvvm-vs-mvc/
	* https://www.toptal.com/ios/swift-tutorial-introduction-to-mvvm
### <a name="markdown-header-project-structure"></a>Project Structure
#### Structure for architecture
```
root dir
        └─── Models 								// Contain models, sources and repositories
        |     └─── model
        |     └─── local
        |     └─── remote
        |     └─── repo
        |
        └─── Views 									// UIView
        |      └─── Cells
        |      |       └─── CustomTableViewCell.swift
        |      └─── MyCustomView
        |              └─── CircleView.swift
        |              └─── XYZView.swift
        |
        └─── Controllers							// UIViewController
        |		└─── featureName					// if has a lot of ViewControllers in each feature.
        |        		└─── HomeViewController
        |        └─── NavigationViewController
        |        └─── TabBarViewController
        |        
        └─── ViewModels
        └─── DI										// Dependency Injection
        └─── Application							// Application Files, Constants, InfoFile
        
        

```

#### Structure for other components and utilities
```
root dir
        └─── Services                   
        |      └─── BaseAPI.swift
        └─── Extensions
        |  
        └─── Helpers
        |		└─── HealthHelper.swift
        |
        └─── Libraries
        |       └─── minizip .swift
        |
        └─── Resources              
        |       └─── ImageAssets         
        |       └─── Sound
```           

## <a name="markdown-header-code-quality"></a>Code Quality

### <a name="markdown-header-coding-convention"></a>Coding Convention
* For file, resource naming and `Java` language rules, please follow [this convention](https://github.com/ribot/android-guidelines/blob/master/project_and_code_guidelines.md).
* For `kotlin` coding style and rules, please follow [this convention](https://developer.android.com/kotlin/style-guide)

### <a name="markdown-header-git-convention"></a>Git Convention
* We will switch branches that are grouped by `version`
* Main branches
	* `master`: stable branch, tag on this branch
	* `develop`: development branch
	* `release-{version}`: main branch for each `version`
* Each version has main topics
	* `{version}/feature/#featureid-do-something`
	* `{version}/fix/#bugid-fix-something`
	* `{version}/research/#id-research-something`
	* `{version}/hotfix`

```

--*-master------------------------------------------------------------------------------------------------------------------------------*------->
  |                                                                                                                                     ↑
  └--*---develop------------------------------------------------------------------------------------------------------------------------|------->
     |                                                                                                                                  |
     |         ┌--------1.0.0/research/#id3-research-something--┐     ┌----1.0.0/fix/#id5-fix-something----┐                            |
     |         |                                                ↓     |                                    ↓                            |
     └--*--*---*-release-1.0.0----------------------*--*----*---*-----*------------------------------*-----*--*----------------------*--┘
        |  |                                        ↑  ↑    |                                        ↑        |                      ↑
        |  └-----1.0.0/feature/#id2-do-something----┘  |    └----1.0.0/feature/#id4-do-something-----┘        └----1.0.0/hotfix------┘
        |                                              |
        └-------1.0.0/feature/#id1-do-something--------┘

```
## <a name="markdown-header-environment-build-apk"></a>Environment and build
### <a name="markdown-header-build-dev"></a>Build Development
### <a name="markdown-header-build-staging"></a>Build Staging
### <a name="markdown-header-build-product"></a>Build Production

## <a name="markdown-header-libraries-and-tools"></a>Libraries and tools included
1. [Alamofire](https://github.com/Alamofire/Alamofire)
2. [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
2. [Firebase](https://firebase.google.com/docs/ios/setup)
3. [Realm](https://github.com/realm/realm-cocoa)
3. [RxRealm](https://github.com/RxSwiftCommunity/RxRealm)
3. [RxSwift](https://github.com/ReactiveX/RxSwift)
4. [Crashlytics](https://fabric.io/kits/ios/crashlytics/install)


Thanks to #TuanTranNhon