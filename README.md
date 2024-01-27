<h1 align="center"> IPSWDownloads </h1>

Provides a Swift-friendly API into the API for [IPSW Downloads](http://ipsw.me). Used by [Bushel](https://getbushel.app).

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FIPSWDownloads%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/IPSWDownloads)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FIPSWDownloads%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/IPSWDownloads)
[![DocC](https://img.shields.io/badge/DocC-read-success?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOBAMAAADtZjDiAAAEsmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjE0IgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMTQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIxNCIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMTQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjEtMDgtMDRUMTU6MzA6MjUtMDQ6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjEtMDgtMDRUMTU6MzA6MjUtMDQ6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS45LjMiCiAgICAgIHN0RXZ0OndoZW49IjIwMjEtMDgtMDRUMTU6MzA6MjUtMDQ6MDAiLz4KICAgIDwvcmRmOlNlcT4KICAgPC94bXBNTTpIaXN0b3J5PgogIDwvcmRmOkRlc2NyaXB0aW9uPgogPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KPD94cGFja2V0IGVuZD0iciI/PmJ/d+MAAAGCaUNDUHNSR0IgSUVDNjE5NjYtMi4xAAAokXWRzytEURTHP/NDJkaEhYXFpBmrIT9qYqPMpKEmTWOUwWbmmR9qfrzem0mTrbKdosTGrwV/AVtlrRSRkp2yJjboOc+okcy5nXs+93vvOd17LlijWSWn2wcgly9qkaDfNRebdzU+4sBOOx7ccUVXx8PhEHXt7QaLGa/6zFr1z/1rzUtJXQGLQ3hMUbWi8KRwaKWomrwp3Klk4kvCx8JeTS4ofG3qiSo/mZyu8ofJWjQSAGubsCv9ixO/WMloOWF5Oe5ctqT83Md8iTOZn52R2CPejU6EIH5cTDFBAB+DjMrso48h+mVFnfyB7/xpCpKryKxSRmOZNBmKeEUtSfWkxJToSRlZymb///ZVTw0PVas7/dDwYBgvHmjcgM+KYbzvG8bnAdju4Sxfyy/swcir6JWa5t6F1jU4Oa9piS04XYeuOzWuxb8lm7g1lYLnI2iJQcclNC1Ue/azz+EtRFflqy5gewd65Xzr4hdYDGff+AQ5OQAAADBQTFRFDGnVkeT/Arf8AAAADUa77vr/DZX9Y9X/A8P/Nc//0vH/DWfWBKj1C4zwnN3/JkXJIU7IDQAAABB0Uk5T////////////////////AOAjXRkAAAAJcEhZcwAADsQAAA7EAZUrDhsAAABkSURBVAiZY/gPAQz////o6AfTs9Z1gOj2cKnwjv8MP7rini8V6mf4MXFp6aqgHoZPnfOiVmmcZ/h2oqmuqNef4VuOhpISC5BOu9RxwMWf4f+3uxdY/EHm3L3AADbvL+9+MA0GABhFRINKb0NBAAAAAElFTkSuQmCC)](https://IPSWDownloads.dev/)


[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/IPSWDownloads)
[![IPSWDownloads](https://github.com/brightdigit/IPSWDownloads/actions/workflows/IPSWDownloads.yml/badge.svg)](https://github.com/brightdigit/IPSWDownloads/actions/workflows/IPSWDownloads.yml)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/IPSWDownloads)


[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/IPSWDownloads)](https://codecov.io/gh/brightdigit/IPSWDownloads)
[![CodeFactor](https://www.codefactor.io/repository/github/brightdigit/IPSWDownloads/badge)](https://www.codefactor.io/repository/github/brightdigit/IPSWDownloads)
[![codebeat badge](https://codebeat.co/badges/a891b07c-4cdb-42cf-a97c-bfae45b378d6)](https://codebeat.co/projects/github-com-brightdigit-ipswdownloads-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/IPSWDownloads)](https://codeclimate.com/github/brightdigit/IPSWDownloads)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/IPSWDownloads?label=debt)](https://codeclimate.com/github/brightdigit/IPSWDownloads)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/IPSWDownloads)](https://codeclimate.com/github/brightdigit/IPSWDownloads)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

## Introduction

Provides a Swift-friendly API into the API for [IPSW Downloads](http://ipsw.me).

## Installation

### Requirements 

**Apple Platforms**

- Xcode 15.0.1 or later
- Swift 5.9 or later
- iOS 17.0 / watchOS 10.0 / tvOS 17.0 / macOS 14.0 / visionOS 1.0 or later deployment targets

**Linux**

- Ubuntu 20.04 or later
- Swift 5.9 or later

### Swift Package Manager

Swift Package Manager is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11.

To integrate **IPSWDownloads** into your project using SPM, specify it in your Package.swift file:

```swift    
let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/brightdigit/IPSWDownloads", from: "1.0.0-beta.1")
  ],
  targets: [
      .target(
          name: "YourTarget",
          dependencies: ["IPSWDownloads", ...]),
      ...
  ]
)
```

If this is for an Xcode project simply import the repo at:

```
https://github.com/brightdigit/IPSWDownloads
```
    
## Usage

_Coming Soon!_

## Documentation

Be sure to check out the [IPSW Downloads API for more details](https://ipswdownloads.docs.apiary.io/).

## Roadmap

## 1.0.0 

- [ ] Coming Soon

## License 

This code is distributed under the MIT license. See the [LICENSE](LICENSE) file for more info.
