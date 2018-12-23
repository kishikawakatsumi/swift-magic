Pod::Spec.new do |spec|
  spec.name = 'swift-magic'
  spec.version = '0.5.3'
  spec.summary = 'A Swift wrapper for libmagic'
  spec.description = <<-DESC
                       swift-magic is a Swift interface to the libmagic file type identification library. libmagic identifies file types by checking their headers according to a predefined list of file types. This functionality is exposed to the command line by the Unix command `file`.
                       ```
                    DESC
  spec.homepage = 'https://github.com/kishikawakatsumi/swift-magic'
  spec.license = { :type => 'BSD', :file => 'LICENSE' }
  spec.author = { 'kishikawa katsumi' => 'kishikawakatsumi@mac.com' }

  spec.requires_arc = true
  spec.source = { git: 'https://github.com/kishikawakatsumi/swift-magic.git', tag: "v#{spec.version}" }
  spec.source_files = 'Magic/**/*.{h,swift}'
  spec.resources = 'Vendor/magic/share/misc/magic.mgc'
  spec.module_name = 'Magic'
  spec.ios.deployment_target = '8.0'
  spec.swift_version = '4.2'

  spec.pod_target_xcconfig = { 'APPLICATION_EXTENSION_API_ONLY' => 'YES',
                               'SWIFT_INCLUDE_PATHS' => '${PODS_ROOT}/swift-magic/Vendor',
                               'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/swift-magic/Vendor/magic/include"',
                               'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/swift-magic/Vendor/magic/lib"' }
  spec.preserve_paths = ['Vendor']
end
