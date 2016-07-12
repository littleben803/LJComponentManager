Pod::Spec.new do |s|
    s.name             = "LJComponentManager"
    s.version          = "1.0.0"
    s.summary          = "链家网组件管理中间件"
    s.description      = "通过ComponentManager＋connector进行业务组件的组件化通信，主要完成URL页面跳转，以及服务调用"
    s.license          = {:type => 'MIT', :file => 'LICENSE'}
    s.homepage         = 'https://github.com/littleben803/LJComponentManager.git'
    s.author           = { "qujieye" => "qujieye@lianjia.com" }
    s.source           = { :git => "https://github.com/littleben803/LJComponentManager.git", :tag => "#{s.version}" }

    s.platform              = :ios, '7.0'
    s.ios.deployment_target = '7.0'
    s.public_header_files = 'LJComponentManager/LJComponentManager/LJCMConnectorPrt.h','LJComponentManager/LJComponentManager/LJComponentManager.h', 'LJComponentManager/LJComponentManager/LJNavigator.h', 'LJComponentManager/LJComponentManager/UIViewController+NavigationTip.h'
    s.source_files = 'LJComponentManager/LJComponentManager/*.{h,m}'
    s.prefix_header_contents = '#import <LJComponentManager/LJComponentManager.h>', '#import <LJComponentManager/LJCMConnectorPrt.h>'
    s.requires_arc = true
end
