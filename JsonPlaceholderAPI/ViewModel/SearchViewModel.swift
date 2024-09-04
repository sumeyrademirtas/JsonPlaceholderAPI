//
//  SearchViewModel.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 4.09.2024.
//

import Foundation

// Bu sınıf, kullanıcı arama işlemini yönetir ve dışa veri sağlar.
class SearchViewModel {
    
    /// Kullanıcıyı ID ile arayan fonksiyon
    /// - Parameters:
    ///  - id: Aranacak kullanıcı ID'si
    ///   - completion: Kullanıcı bulunduğunda çağrılacak closure, 'User?' döner
    func fetchUser(by id: Int, completion: @escaping (User?) -> Void) {
        // API'ye yapılan istek için request objesi oluşturuluyor
        // 'pathComponents' ile 'id' endpoint'e ekleniyor
        let request = Request(endpoint: .users, pathComponents: ["\(id)"])
        
        // Servis üzerinden API isteği yapılıyor
        // Gelen cevap User modelini temsil ediyor
        Service.shared.execute(request, expecting: User.self) { result in
            // Gelen sonuçları switch ile değerlendiriyoruz
            switch result {
            case .success(let user):
                // Kullanıcı bulunduğunda completion callback fonksiyonu ile veriyi döneriz
                completion(user)
            case .failure:
                // Hata durumunda veya kullanıcı bulunamazsa nil döneriz
                completion(nil)
            }
        }
    }
}
