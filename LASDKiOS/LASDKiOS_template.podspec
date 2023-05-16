Pod::Spec.new do |s|
s.name              = 'LASDKiOS'
s.version           = 'CHANGE_ME'
s.summary           = 'LASDKiOS XCFramework'
s.homepage          = 'https://github.com/cbajapan/swift-lasdk-ios'

s.author            = { 'Name' => 'Communication Business Avenue, Inc.' }
s.license           = { :type => 'Commercial', :text => 'Copyright Communication Business Avenue, Inc. Use of this software is subject to the terms and conditions located at https://github.com/cbajapan/swift-lasdk-ios/blob/main/License.txt'}

s.source            = { :http => 'https://swift-sdk.s3.us-east-2.amazonaws.com/lasdk/LASDKiOS-CHANGE_ME.xcframework.zip' }

s.platforms = { :ios => "11.0" }

s.vendored_frameworks = 'LASDKiOS.xcframework'
end
