# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

project 'Contacts.xcodeproj'

def contacts_pods
  # Pods for Contacts
  pod 'Hue'
  pod 'NVActivityIndicatorView'
  pod 'EasyPeasy'
  pod 'IQKeyboardManagerSwift'
  pod 'RealmSwift'
#  pod 'SwiftyJSON'
#  pod 'Material'
  pod 'Moya/RxSwift'
  pod 'Kingfisher', '~> 3.0'
  pod 'ObjectMapper'
end

target 'Contacts' do
    contacts_pods
end

target 'ContactsTests' do
	inherit! :search_paths
    contacts_pods
end

target 'ContactsUITests' do
	inherit! :search_paths
    contacts_pods
end
