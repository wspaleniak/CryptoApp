//
//  MarketData.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 09/06/2023.
//

import Foundation

struct GlobalData: Codable {
    let data: MarketData?
}

// użyjemy tylko tych, których potrzebujemy, resztę pomijamy
struct MarketData: Codable {
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24hUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        guard let item = totalMarketCap.first(where: { $0.key == "usd" }) else {
            return ""
        }
        return "$" + item.value.formattedWithAbbreviations()
    }
    
    var volume: String {
        guard let item = totalVolume.first(where: { $0.key == "usd" }) else {
            return ""
        }
        return "$" + item.value.formattedWithAbbreviations()
    }
    
    var btcDominance: String {
        guard let item = marketCapPercentage.first(where: { $0.key == "btc" }) else {
            return ""
        }
        return item.value.asPercentString()
    }
}

// MARK: - CoinGecko API info
/*
 
 URL:
 https://api.coingecko.com/api/v3/global
 
 >> Dostajemy jako obiekt
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 10014,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 752,
     "total_market_cap": {
       "btc": 43363226.0153557,
       "eth": 623806763.4268109,
       "ltc": 12824563101.890049,
       "bch": 10343904728.173584,
       "bnb": 4384139267.795596,
       "eos": 1274120936559.278,
       "xrp": 2155393786756.462,
       "xlm": 13057207256580.309,
       "link": 191239301142.021,
       "dot": 228027169418.86865,
       "yfi": 193289039.52448654,
       "usd": 1147935811415.6528,
       "aed": 4216333797255.348,
       "ars": 280567221255262.1,
       "aud": 1703635466620.609,
       "bdt": 124199139259416.42,
       "bhd": 432709812369.88434,
       "bmd": 1147935811415.6528,
       "brl": 5606862883697.478,
       "cad": 1532371479108.076,
       "chf": 1036550451698.1783,
       "clp": 903643591388287.6,
       "cny": 8183175225257.619,
       "czk": 25311525467390.574,
       "dkk": 7961508820073.259,
       "eur": 1068258734681.1025,
       "gbp": 912687029710.6204,
       "hkd": 8998381841734.436,
       "huf": 393051328882566.3,
       "idr": 17076635733828666,
       "ils": 4120481157002.143,
       "inr": 94652709837149.22,
       "jpy": 159977452997952.66,
       "krw": 1480804946617506,
       "kwd": 352671135854.7397,
       "lkr": 337593956350261.9,
       "mmk": 2409274765573358.5,
       "mxn": 19840819250285.11,
       "myr": 5296575833871.841,
       "ngn": 530805519198597.5,
       "nok": 12348563631202.344,
       "nzd": 1873950111217.1057,
       "php": 64390015533926.87,
       "pkr": 329263305811311.3,
       "pln": 4745438075581.419,
       "rub": 94647307651220.44,
       "sar": 4305251757271.7935,
       "sek": 12427492253787.865,
       "sgd": 1542555965626.9539,
       "thb": 39707099716867.44,
       "try": 26882934799637.44,
       "twd": 35272047413591.42,
       "uah": 42369979045902.21,
       "vef": 114942812797.04933,
       "vnd": 26953183014009244,
       "zar": 21485455407942.188,
       "xdr": 862464837961.1865,
       "xag": 47220729900.75893,
       "xau": 585125841.7947851,
       "bits": 43363226015355.695,
       "sats": 4336322601535570
     },
     "total_volume": {
       "btc": 1088619.4407506809,
       "eth": 15660462.38574846,
       "ltc": 321956413.1807789,
       "bch": 259680305.52835435,
       "bnb": 110062365.65957192,
       "eos": 31986384521.177498,
       "xrp": 54110447822.895096,
       "xlm": 327796867705.1527,
       "link": 4800999376.408371,
       "dot": 5724546636.839822,
       "yfi": 4852457.380266633,
       "usd": 28818548707.57213,
       "aed": 105849664846.45114,
       "ars": 7043547253327.448,
       "aud": 42769204677.225845,
       "bdt": 3117978295120.919,
       "bhd": 10863036661.124474,
       "bmd": 28818548707.57213,
       "brl": 140758437452.39465,
       "cad": 38469678939.8971,
       "chf": 26022256107.92764,
       "clp": 22685673357113.7,
       "cny": 205435906316.79858,
       "czk": 635437471582.4823,
       "dkk": 199871044561.36646,
       "eur": 26818282060.328224,
       "gbp": 22912705883.83196,
       "hkd": 225901398681.48068,
       "huf": 9867423555685.873,
       "idr": 428703289646407.25,
       "ils": 103443316029.36891,
       "inr": 2376224961029.543,
       "jpy": 4016181022917.3975,
       "krw": 37175118204460.65,
       "kwd": 8853692171.037724,
       "lkr": 8475184568433.388,
       "mmk": 60484045789960.88,
       "mxn": 498097202192.2928,
       "myr": 132968783736.73827,
       "ngn": 13325696922381.344,
       "nok": 310006603971.6078,
       "nzd": 47044897474.773544,
       "php": 1616490034105.1377,
       "pkr": 8266046343164.117,
       "pln": 119132652679.64764,
       "rub": 2376089340939.3184,
       "sar": 108081920810.79097,
       "sek": 311988080925.09467,
       "sgd": 38725357104.03064,
       "thb": 996833599794.9199,
       "try": 674887182908.2772,
       "twd": 885493079226.1172,
       "uah": 1063684304235.9099,
       "vef": 2885601282.0891976,
       "vnd": 676650741085800.4,
       "zar": 539385248740.144,
       "xdr": 21651894377.8757,
       "xag": 1185460799.3925443,
       "xau": 14689390.64722363,
       "bits": 1088619440750.6809,
       "sats": 108861944075068.1
     },
     "market_cap_percentage": {
       "btc": 44.732472148476724,
       "eth": 19.27459180800659,
       "usdt": 7.255112969546916,
       "bnb": 3.5550797343436296,
       "usdc": 2.4708313976313994,
       "xrp": 2.4124025610992885,
       "steth": 1.1463486504534104,
       "ada": 0.9464484158390407,
       "doge": 0.8378058154702325,
       "sol": 0.6432975467063663
     },
     "market_cap_change_percentage_24h_usd": -0.6367739393124703,
     "updated_at": 1686329025
   }
 }
 
 */
