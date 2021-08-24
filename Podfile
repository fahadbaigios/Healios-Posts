
source 'https://github.com/CocoaPods/Specs.git'

###################################################Global Config###################################################

platform :ios, '12.0'
use_frameworks!
workspace 'Healios Posts'

###################################################Common Pods###################################################
def uiPods

  pod 'RxKingfisher', '~> 1.0.0'
  pod 'SVProgressHUD'
  pod 'SwiftMessages', '~> 8.0'
  pod 'SDWebImage', '~> 4.0'
  
end

def commonpods
  pod 'RxSwift', '~> 5.1'
  pod 'RxRelay', '~> 5.0'
  pod 'Reusable',  '~> 4.1'
  pod 'RxDataSources', '~> 4.0'
end

def resourcePods
  pod 'R.swift', '~> 5.0' 
end

#Navigation Pods
def navigationPods
  pod 'RxFlow', '~> 2.9'
end

def storePods
   pod "Moya/RxSwift", '~> 14.0.0-alpha.1'
   pod 'SerializedSwift'
   pod 'RealmSwift', '~> 3.20'
end

###################################################Targets###################################################

target 'Utilities' do
  project 'Utilities/Utilities.xcodeproj'
  commonpods
  resourcePods
  #uiPods
  
end

target 'Store' do
  project 'Store/Store.xcodeproj'
  commonpods
  storePods
  resourcePods
end

target 'Healios Posts' do
 commonpods
 resourcePods
 storePods
 uiPods
 navigationPods
 
 pod 'IQKeyboardManagerSwift', '~> 6.3'
 pod 'Kingfisher', '~> 5.8'
 
end
