//

import Foundation


enum USERDEFAULTS_KEYS: String {
    case user
    
}

let USERDEFAULTS = UserDefaults.standard

func USERDEFAULTS_SET_STRING_KEY(object:String, key:String) -> Void {
    USERDEFAULTS .set(object, forKey: key)
    USERDEFAULTS.synchronize()
}
func USERDEFAULTS_GET_STRING_KEY(key:String) -> String {
    return USERDEFAULTS.object(forKey: key) as? String == nil ? "" : USERDEFAULTS.object(forKey: key) as! String
}
func USERDEFAULTS_SET_BOOL_KEY(object:Bool, key:String) -> Void {
    USERDEFAULTS .set(object, forKey: key)
    USERDEFAULTS.synchronize()
}
func USERDEFAULTS_GET_BOOL_KEY(key:String) -> Bool {
    return USERDEFAULTS.object(forKey: key) as? Bool == nil ? false : USERDEFAULTS.object(forKey: key) as! Bool
    
}
func USERDEFAULTS_SET_INT_KEY(object:Int, key:String) -> Void {
    USERDEFAULTS .set(object, forKey: key)
    USERDEFAULTS.synchronize()
}
func USERDEFAULTS_GET_INT_KEY(key:String) -> Int {
    return USERDEFAULTS.object(forKey: key) as? Int == nil ? 0 : USERDEFAULTS.object(forKey: key) as! Int
}

func USERDEFAULTS_SET_USER_OBJECT(object:User) -> Void {
    USERDEFAULTS .set(try? PropertyListEncoder().encode(object), forKey: USERDEFAULTS_KEYS.user.rawValue)
    USERDEFAULTS.synchronize()
}
func USERDEFAULTS_GET_USER_OBJECT() -> User? {
    
    guard let data = USERDEFAULTS.object(forKey: USERDEFAULTS_KEYS.user.rawValue) as? Data else{
        return nil
    }
    let user = try? PropertyListDecoder().decode(User.self, from: data)
    return user
}
func USERDEFAULTS_REMOVE_OBJECT(key:String){
    USERDEFAULTS.removeObject(forKey: key)
    USERDEFAULTS.synchronize()
}
