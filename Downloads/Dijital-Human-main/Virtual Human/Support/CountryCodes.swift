//
//  CountryCodes.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

import Foundation

/**
 # CountryCode
 ## English
 A struct representing a country with its code and flag.
 Used for phone number input in registration forms.
 
 ## Azərbaycanca
 Ölkəni onun kodu və bayrağı ilə təmsil edən struct.
 Qeydiyyat formalarında telefon nömrəsi daxil edilməsi üçün istifadə olunur.
 */
struct CountryCode: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let code: String
    let flag: String
    
    static func == (lhs: CountryCode, rhs: CountryCode) -> Bool {
        lhs.code == rhs.code
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}

/**
 # CountryCodes
 ## English
 A collection of country codes with their respective flags.
 Organized alphabetically by country name.
 
 ## Azərbaycanca
 Müvafiq bayraqları ilə ölkə kodlarının kolleksiyası.
 Ölkə adına görə əlifba sırası ilə təşkil olunub.
 */
class CountryCodes {
    /**
     ## English
     Returns an array of all country codes with their flags.
     Sorted alphabetically by country name.
     
     ## Azərbaycanca
     Bütün ölkə kodlarını və bayraqlarını array şəklində qaytarır.
     Ölkə adına görə əlifba sırası ilə sıralanıb.
     */
    static let all: [CountryCode] = [
        CountryCode(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
        CountryCode(name: "Albania", code: "+355", flag: "🇦🇱"),
        CountryCode(name: "Algeria", code: "+213", flag: "🇩🇿"),
        CountryCode(name: "Andorra", code: "+376", flag: "🇦🇩"),
        CountryCode(name: "Angola", code: "+244", flag: "🇦🇴"),
        CountryCode(name: "Antigua and Barbuda", code: "+1-268", flag: "🇦🇬"),
        CountryCode(name: "Argentina", code: "+54", flag: "🇦🇷"),
        CountryCode(name: "Armenia", code: "+374", flag: "🇦🇲"),
        CountryCode(name: "Australia", code: "+61", flag: "🇦🇺"),
        CountryCode(name: "Austria", code: "+43", flag: "🇦🇹"),
        CountryCode(name: "Azerbaijan", code: "+994", flag: "🇦🇿"),
        CountryCode(name: "Bahamas", code: "+1-242", flag: "🇧🇸"),
        CountryCode(name: "Bahrain", code: "+973", flag: "🇧🇭"),
        CountryCode(name: "Bangladesh", code: "+880", flag: "🇧🇩"),
        CountryCode(name: "Barbados", code: "+1-246", flag: "🇧🇧"),
        CountryCode(name: "Belarus", code: "+375", flag: "🇧🇾"),
        CountryCode(name: "Belgium", code: "+32", flag: "🇧🇪"),
        CountryCode(name: "Belize", code: "+501", flag: "🇧🇿"),
        CountryCode(name: "Benin", code: "+229", flag: "🇧🇯"),
        CountryCode(name: "Bhutan", code: "+975", flag: "🇧🇹"),
        CountryCode(name: "Bolivia", code: "+591", flag: "🇧🇴"),
        CountryCode(name: "Bosnia and Herzegovina", code: "+387", flag: "🇧🇦"),
        CountryCode(name: "Botswana", code: "+267", flag: "🇧🇼"),
        CountryCode(name: "Brazil", code: "+55", flag: "🇧🇷"),
        CountryCode(name: "Brunei", code: "+673", flag: "🇧🇳"),
        CountryCode(name: "Bulgaria", code: "+359", flag: "🇧🇬"),
        CountryCode(name: "Burkina Faso", code: "+226", flag: "🇧🇫"),
        CountryCode(name: "Burundi", code: "+257", flag: "🇧🇮"),
        CountryCode(name: "Cambodia", code: "+855", flag: "🇰🇭"),
        CountryCode(name: "Cameroon", code: "+237", flag: "🇨🇲"),
        CountryCode(name: "Canada", code: "+1", flag: "🇨🇦"),
        CountryCode(name: "Cape Verde", code: "+238", flag: "🇨🇻"),
        CountryCode(name: "Central African Republic", code: "+236", flag: "🇨🇫"),
        CountryCode(name: "Chad", code: "+235", flag: "🇹🇩"),
        CountryCode(name: "Chile", code: "+56", flag: "🇨🇱"),
        CountryCode(name: "China", code: "+86", flag: "🇨🇳"),
        CountryCode(name: "Colombia", code: "+57", flag: "🇨🇴"),
        CountryCode(name: "Comoros", code: "+269", flag: "🇰🇲"),
        CountryCode(name: "Congo", code: "+242", flag: "🇨🇬"),
        CountryCode(name: "Costa Rica", code: "+506", flag: "🇨🇷"),
        CountryCode(name: "Croatia", code: "+385", flag: "🇭🇷"),
        CountryCode(name: "Cuba", code: "+53", flag: "🇨🇺"),
        CountryCode(name: "Cyprus", code: "+357", flag: "🇨🇾"),
        CountryCode(name: "Czech Republic", code: "+420", flag: "🇨🇿"),
        CountryCode(name: "Denmark", code: "+45", flag: "🇩🇰"),
        CountryCode(name: "Djibouti", code: "+253", flag: "🇩🇯"),
        CountryCode(name: "Dominica", code: "+1-767", flag: "🇩🇲"),
        CountryCode(name: "Dominican Republic", code: "+1-809", flag: "🇩🇴"),
        CountryCode(name: "Ecuador", code: "+593", flag: "🇪🇨"),
        CountryCode(name: "Egypt", code: "+20", flag: "🇪🇬"),
        CountryCode(name: "El Salvador", code: "+503", flag: "🇸🇻"),
        CountryCode(name: "Equatorial Guinea", code: "+240", flag: "🇬🇶"),
        CountryCode(name: "Eritrea", code: "+291", flag: "🇪🇷"),
        CountryCode(name: "Estonia", code: "+372", flag: "🇪🇪"),
        CountryCode(name: "Eswatini", code: "+268", flag: "🇸🇿"),
        CountryCode(name: "Ethiopia", code: "+251", flag: "🇪🇹"),
        CountryCode(name: "Fiji", code: "+679", flag: "🇫🇯"),
        CountryCode(name: "Finland", code: "+358", flag: "🇫🇮"),
        CountryCode(name: "France", code: "+33", flag: "🇫🇷"),
        CountryCode(name: "Gabon", code: "+241", flag: "🇬🇦"),
        CountryCode(name: "Gambia", code: "+220", flag: "🇬🇲"),
        CountryCode(name: "Georgia", code: "+995", flag: "🇬🇪"),
        CountryCode(name: "Germany", code: "+49", flag: "🇩🇪"),
        CountryCode(name: "Ghana", code: "+233", flag: "🇬🇭"),
        CountryCode(name: "Greece", code: "+30", flag: "🇬🇷"),
        CountryCode(name: "Grenada", code: "+1-473", flag: "🇬🇩"),
        CountryCode(name: "Guatemala", code: "+502", flag: "🇬🇹"),
        CountryCode(name: "Guinea", code: "+224", flag: "🇬🇳"),
        CountryCode(name: "Guinea-Bissau", code: "+245", flag: "🇬🇼"),
        CountryCode(name: "Guyana", code: "+592", flag: "🇬🇾"),
        CountryCode(name: "Haiti", code: "+509", flag: "🇭🇹"),
        CountryCode(name: "Honduras", code: "+504", flag: "🇭🇳"),
        CountryCode(name: "Hungary", code: "+36", flag: "🇭🇺"),
        CountryCode(name: "Iceland", code: "+354", flag: "🇮🇸"),
        CountryCode(name: "India", code: "+91", flag: "🇮🇳"),
        CountryCode(name: "Indonesia", code: "+62", flag: "🇮🇩"),
        CountryCode(name: "Iran", code: "+98", flag: "🇮🇷"),
        CountryCode(name: "Iraq", code: "+964", flag: "🇮🇶"),
        CountryCode(name: "Ireland", code: "+353", flag: "🇮🇪"),
        CountryCode(name: "Israel", code: "+972", flag: "🇮🇱"),
        CountryCode(name: "Italy", code: "+39", flag: "🇮🇹"),
        CountryCode(name: "Jamaica", code: "+1-876", flag: "🇯🇲"),
        CountryCode(name: "Japan", code: "+81", flag: "🇯🇵"),
        CountryCode(name: "Jordan", code: "+962", flag: "🇯🇴"),
        CountryCode(name: "Kazakhstan", code: "+7", flag: "🇰🇿"),
        CountryCode(name: "Kenya", code: "+254", flag: "🇰🇪"),
        CountryCode(name: "Kiribati", code: "+686", flag: "🇰🇮"),
        CountryCode(name: "Kuwait", code: "+965", flag: "🇰🇼"),
        CountryCode(name: "Kyrgyzstan", code: "+996", flag: "🇰🇬"),
        CountryCode(name: "Laos", code: "+856", flag: "🇱🇦"),
        CountryCode(name: "Latvia", code: "+371", flag: "🇱🇻"),
        CountryCode(name: "Lebanon", code: "+961", flag: "🇱🇧"),
        CountryCode(name: "Lesotho", code: "+266", flag: "🇱🇸"),
        CountryCode(name: "Liberia", code: "+231", flag: "🇱🇷"),
        CountryCode(name: "Libya", code: "+218", flag: "🇱🇾"),
        CountryCode(name: "Liechtenstein", code: "+423", flag: "🇱🇮"),
        CountryCode(name: "Lithuania", code: "+370", flag: "🇱🇹"),
        CountryCode(name: "Luxembourg", code: "+352", flag: "🇱🇺"),
        CountryCode(name: "Madagascar", code: "+261", flag: "🇲🇬"),
        CountryCode(name: "Malawi", code: "+265", flag: "🇲🇼"),
        CountryCode(name: "Malaysia", code: "+60", flag: "🇲🇾"),
        CountryCode(name: "Maldives", code: "+960", flag: "🇲🇻"),
        CountryCode(name: "Mali", code: "+223", flag: "🇲🇱"),
        CountryCode(name: "Malta", code: "+356", flag: "🇲🇹"),
        CountryCode(name: "Marshall Islands", code: "+692", flag: "🇲🇭"),
        CountryCode(name: "Mauritania", code: "+222", flag: "🇲🇷"),
        CountryCode(name: "Mauritius", code: "+230", flag: "🇲🇺"),
        CountryCode(name: "Mexico", code: "+52", flag: "🇲🇽"),
        CountryCode(name: "Micronesia", code: "+691", flag: "🇫🇲"),
        CountryCode(name: "Moldova", code: "+373", flag: "🇲🇩"),
        CountryCode(name: "Monaco", code: "+377", flag: "🇲🇨"),
        CountryCode(name: "Mongolia", code: "+976", flag: "🇲🇳"),
        CountryCode(name: "Montenegro", code: "+382", flag: "🇲🇪"),
        CountryCode(name: "Morocco", code: "+212", flag: "🇲🇦"),
        CountryCode(name: "Mozambique", code: "+258", flag: "🇲🇿"),
        CountryCode(name: "Myanmar", code: "+95", flag: "🇲🇲"),
        CountryCode(name: "Namibia", code: "+264", flag: "🇳🇦"),
        CountryCode(name: "Nauru", code: "+674", flag: "🇳🇷"),
        CountryCode(name: "Nepal", code: "+977", flag: "🇳🇵"),
        CountryCode(name: "Netherlands", code: "+31", flag: "🇳🇱"),
        CountryCode(name: "New Zealand", code: "+64", flag: "🇳🇿"),
        CountryCode(name: "Nicaragua", code: "+505", flag: "🇳🇮"),
        CountryCode(name: "Niger", code: "+227", flag: "🇳🇪"),
        CountryCode(name: "Nigeria", code: "+234", flag: "🇳🇬"),
        CountryCode(name: "North Korea", code: "+850", flag: "🇰🇵"),
        CountryCode(name: "North Macedonia", code: "+389", flag: "🇲🇰"),
        CountryCode(name: "Norway", code: "+47", flag: "🇳🇴"),
        CountryCode(name: "Oman", code: "+968", flag: "🇴🇲"),
        CountryCode(name: "Pakistan", code: "+92", flag: "🇵🇰"),
        CountryCode(name: "Palau", code: "+680", flag: "🇵🇼"),
        CountryCode(name: "Panama", code: "+507", flag: "🇵🇦"),
        CountryCode(name: "Papua New Guinea", code: "+675", flag: "🇵🇬"),
        CountryCode(name: "Paraguay", code: "+595", flag: "🇵🇾"),
        CountryCode(name: "Peru", code: "+51", flag: "🇵🇪"),
        CountryCode(name: "Philippines", code: "+63", flag: "🇵🇭"),
        CountryCode(name: "Poland", code: "+48", flag: "🇵🇱"),
        CountryCode(name: "Portugal", code: "+351", flag: "🇵🇹"),
        CountryCode(name: "Qatar", code: "+974", flag: "🇶🇦"),
        CountryCode(name: "Romania", code: "+40", flag: "🇷🇴"),
        CountryCode(name: "Russia", code: "+7", flag: "🇷🇺"),
        CountryCode(name: "Rwanda", code: "+250", flag: "🇷🇼"),
        CountryCode(name: "Saint Kitts and Nevis", code: "+1-869", flag: "🇰🇳"),
        CountryCode(name: "Saint Lucia", code: "+1-758", flag: "🇱🇨"),
        CountryCode(name: "Saint Vincent and the Grenadines", code: "+1-784", flag: "🇻🇨"),
        CountryCode(name: "Samoa", code: "+685", flag: "🇼🇸"),
        CountryCode(name: "San Marino", code: "+378", flag: "🇸🇲"),
        CountryCode(name: "Sao Tome and Principe", code: "+239", flag: "🇸🇹"),
        CountryCode(name: "Saudi Arabia", code: "+966", flag: "🇸🇦"),
        CountryCode(name: "Senegal", code: "+221", flag: "🇸🇳"),
        CountryCode(name: "Serbia", code: "+381", flag: "🇷🇸"),
        CountryCode(name: "Seychelles", code: "+248", flag: "🇸🇨"),
        CountryCode(name: "Sierra Leone", code: "+232", flag: "🇸🇱"),
        CountryCode(name: "Singapore", code: "+65", flag: "🇸🇬"),
        CountryCode(name: "Slovakia", code: "+421", flag: "🇸🇰"),
        CountryCode(name: "Slovenia", code: "+386", flag: "🇸🇮"),
        CountryCode(name: "Solomon Islands", code: "+677", flag: "🇸🇧"),
        CountryCode(name: "Somalia", code: "+252", flag: "🇸🇴"),
        CountryCode(name: "South Africa", code: "+27", flag: "🇿🇦"),
        CountryCode(name: "South Korea", code: "+82", flag: "🇰🇷"),
        CountryCode(name: "South Sudan", code: "+211", flag: "🇸🇸"),
        CountryCode(name: "Spain", code: "+34", flag: "🇪🇸"),
        CountryCode(name: "Sri Lanka", code: "+94", flag: "🇱🇰"),
        CountryCode(name: "Sudan", code: "+249", flag: "🇸🇩"),
        CountryCode(name: "Suriname", code: "+597", flag: "🇸🇷"),
        CountryCode(name: "Sweden", code: "+46", flag: "🇸🇪"),
        CountryCode(name: "Switzerland", code: "+41", flag: "🇨🇭"),
        CountryCode(name: "Syria", code: "+963", flag: "🇸🇾"),
        CountryCode(name: "Taiwan", code: "+886", flag: "🇹🇼"),
        CountryCode(name: "Tajikistan", code: "+992", flag: "🇹🇯"),
        CountryCode(name: "Tanzania", code: "+255", flag: "🇹🇿"),
        CountryCode(name: "Thailand", code: "+66", flag: "🇹🇭"),
        CountryCode(name: "Timor-Leste", code: "+670", flag: "🇹🇱"),
        CountryCode(name: "Togo", code: "+228", flag: "🇹🇬"),
        CountryCode(name: "Tonga", code: "+676", flag: "🇹🇴"),
        CountryCode(name: "Trinidad and Tobago", code: "+1-868", flag: "🇹🇹"),
        CountryCode(name: "Tunisia", code: "+216", flag: "🇹🇳"),
        CountryCode(name: "Turkey", code: "+90", flag: "🇹🇷"),
        CountryCode(name: "Turkmenistan", code: "+993", flag: "🇹🇲"),
        CountryCode(name: "Tuvalu", code: "+688", flag: "🇹🇻"),
        CountryCode(name: "Uganda", code: "+256", flag: "🇺🇬"),
        CountryCode(name: "Ukraine", code: "+380", flag: "🇺🇦"),
        CountryCode(name: "United Arab Emirates", code: "+971", flag: "🇦🇪"),
        CountryCode(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
        CountryCode(name: "United States", code: "+1", flag: "🇺🇸"),
        CountryCode(name: "Uruguay", code: "+598", flag: "🇺🇾"),
        CountryCode(name: "Uzbekistan", code: "+998", flag: "🇺🇿"),
        CountryCode(name: "Vanuatu", code: "+678", flag: "🇻🇺"),
        CountryCode(name: "Vatican City", code: "+379", flag: "🇻🇦"),
        CountryCode(name: "Venezuela", code: "+58", flag: "🇻🇪"),
        CountryCode(name: "Vietnam", code: "+84", flag: "🇻🇳"),
        CountryCode(name: "Yemen", code: "+967", flag: "🇾🇪"),
        CountryCode(name: "Zambia", code: "+260", flag: "🇿🇲"),
        CountryCode(name: "Zimbabwe", code: "+263", flag: "🇿🇼")
    ]
} 