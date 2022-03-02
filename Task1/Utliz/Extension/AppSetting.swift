

import Foundation

final class AppSettings {
    private enum SettingKey: String {
        case hasLogin
        case name
        case lastName
        case email
        case password
        case token
        case userId

       
    }
    static var hasLogIn: Bool {
        get {
            return USERDEFAULTS_GET_BOOL_KEY(key: SettingKey.hasLogin.rawValue)
        }
        set {
            USERDEFAULTS_SET_BOOL_KEY(object: newValue, key: SettingKey.hasLogin.rawValue)
        }
    }
  
  
    static var token: String {
        get {
            return USERDEFAULTS_GET_STRING_KEY(key: SettingKey.token.rawValue)
        }
        set {
            USERDEFAULTS_SET_STRING_KEY(object: newValue, key: SettingKey.token.rawValue)
        }
    }
    static var name: String {
        get {
            return USERDEFAULTS_GET_STRING_KEY(key: SettingKey.name.rawValue)
        }
        set {
            USERDEFAULTS_SET_STRING_KEY(object: newValue, key: SettingKey.name.rawValue)
        }
    }
    
    static var lastName: String {
        get {
            return USERDEFAULTS_GET_STRING_KEY(key: SettingKey.lastName.rawValue)
        }
        set {
            USERDEFAULTS_SET_STRING_KEY(object: newValue, key: SettingKey.lastName.rawValue)
        }
    }
    static var email: String {
        get {
            return USERDEFAULTS_GET_STRING_KEY(key: SettingKey.email.rawValue)
        }
        set {
            USERDEFAULTS_SET_STRING_KEY(object: newValue, key: SettingKey.email.rawValue)
        }
    }
    static var pasword: String {
        get {
            return USERDEFAULTS_GET_STRING_KEY(key: SettingKey.password.rawValue)
        }
        set {
            USERDEFAULTS_SET_STRING_KEY(object: newValue, key: SettingKey.password.rawValue)
        }
    }
 
    
    static var userId: String {
        get {
            return USERDEFAULTS_GET_STRING_KEY(key: SettingKey.userId.rawValue)
        }
        set {
            USERDEFAULTS_SET_STRING_KEY(object: newValue, key: SettingKey.userId.rawValue)
        }
    }
 
}
