//


import Foundation

protocol MediaModel{
    var keyName  : String { get set }
    var filename : String { get set }
    var image_data  : Data   { get set }
    var mimeType : String { get set }
    var fileSize : String { get set }
    
}

struct ImagesRequestModel : MediaModel{
    
    var keyName  : String
    var filename : String
    var image_data  : Data
    var mimeType : String
    var fileSize : String
    var thumbnailImgData : Data
  
    init(_ key:String, withImgData imgdata:Data, size fileSize:String = "0", mime mimeType:String = "image/jpeg", thumbnailData imgData:Data = Data()) {
        
        self.keyName     = key
        self.image_data  = imgdata
        self.mimeType    = mimeType
        self.fileSize    = fileSize
        
        self.thumbnailImgData = imgData
        
        if self.mimeType == "image/jpeg"{
            self.filename = "\(Date().timeIntervalSince1970 * 1000).jpeg"
        }else{
            self.filename = "\(Date().timeIntervalSince1970 * 1000).xlsx"
        }
        
    }
    
    
}
