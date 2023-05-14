//
//  PreviewProvider+Ex.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 07/04/2023.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init() {}
    
    let homeVM = HomeViewModel()
    
    let coin = Coin(id: "bitcoin",
                    symbol: "btc",
                    name: "Bitcoin",
                    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                    currentPrice: 27895,
                    marketCap: 539752276968,
                    marketCapRank: 1,
                    fullyDilutedValuation: 586095701354,
                    totalVolume: 12261090246,
                    high24H: 28185,
                    low24H: 27845,
                    priceChange24H: -56.50422570655064,
                    priceChangePercentage24H: -0.20215,
                    marketCapChange24H: -1147887895.7700195,
                    marketCapChangePercentage24H: -0.21222,
                    circulatingSupply: 19339500,
                    totalSupply: 21000000,
                    maxSupply: 21000000,
                    ath: 69045,
                    athChangePercentage: -59.53251,
                    athDate: "2021-11-10T14:24:11.849Z",
                    atl: 67.81,
                    atlChangePercentage: 41104.9782,
                    atlDate: "2013-07-06T00:00:00.000Z",
                    lastUpdated: "2023-04-07T08:54:00.821Z",
                    sparklineIn7D: SparklineIn7D(price: [
                        28067.573064673663,
                        28102.470225017663,
                        27755.849630502697,
                        27843.27172950751,
                        27834.11811146376,
                        27952.205531422333,
                        27973.01090521896,
                        28098.568480575395,
                        28433.95699730183,
                        28573.195069797803,
                        28453.70588056674,
                        28427.133069662952,
                        28331.91907922445,
                        28396.930826425294,
                        28480.679190765833,
                        28449.801858037066,
                        28545.696125542672,
                        28614.720752692487,
                        28512.59557632949,
                        28461.85231762472,
                        28630.791082786527,
                        28616.450159987104,
                        28592.13249069683,
                        28614.036511384336,
                        28606.087345747008,
                        28516.00446026185,
                        28482.773400308706,
                        28489.062789309723,
                        28472.541617701205,
                        28497.089317751925,
                        28431.090850350232,
                        28466.964412373334,
                        28453.623792675688,
                        28369.27869767466,
                        28426.160144518566,
                        28370.86183763751,
                        28393.676717620543,
                        28383.38686781035,
                        28432.913648887734,
                        28492.864870796544,
                        28505.277241162796,
                        28564.345476006813,
                        28498.94463304862,
                        28403.25263834422,
                        28442.2224689886,
                        28467.103894987176,
                        28517.272533917327,
                        28487.426973853362,
                        28501.654471492504,
                        28504.51050870916,
                        28473.277004171265,
                        28412.27804902953,
                        28445.869300072864,
                        28429.943625881864,
                        28388.710003219458,
                        28307.968056852653,
                        28332.15046338308,
                        28318.308509846203,
                        28175.355686579394,
                        28183.665119265013,
                        28243.137702410924,
                        28228.88842602772,
                        28062.663620601237,
                        28135.20345675213,
                        28047.225221894947,
                        28137.427100096582,
                        28242.70792495667,
                        28153.216356059926,
                        27731.186467529376,
                        27789.901993775264,
                        27813.616907970005,
                        27685.863218282448,
                        27742.19048696542,
                        27775.398120697984,
                        27974.12349256964,
                        28353.10087338,
                        28365.158553817495,
                        28354.626765787296,
                        28298.63388116931,
                        28181.076894144888,
                        28257.79514031741,
                        28054.965491108025,
                        28062.580504620128,
                        28045.57857633993,
                        28025.392925692067,
                        28183.587869681913,
                        28115.525959322884,
                        27629.00805255512,
                        27832.500814526797,
                        27832.4729690141,
                        27815.42653124798,
                        27789.60027092099,
                        27855.86054002738,
                        27931.757218125018,
                        27911.60390022797,
                        27845.144820465222,
                        27935.229910451228,
                        28138.451687039073,
                        28013.378286016043,
                        28088.674361572674,
                        28182.64756150609,
                        28233.343436881743,
                        28305.012139287173,
                        28280.005005551244,
                        28129.4876628722,
                        28195.613349729876,
                        28051.714934238462,
                        28111.743520868433,
                        28204.780999548057,
                        28209.17134671452,
                        28194.775836923025,
                        28311.006512969114,
                        28223.534205566517,
                        28229.870793863745,
                        28175.33033421539,
                        28467.098329710636,
                        28616.1654711853,
                        28568.412144461367,
                        28511.586549751024,
                        28523.660413248697,
                        28577.315767234333,
                        28555.60474457757,
                        28522.720117964443,
                        28578.94571421836,
                        28527.119485595544,
                        28508.37797334716,
                        28540.125449830215,
                        28576.71707026462,
                        28403.32255039985,
                        28167.405631498907,
                        28118.758778204396,
                        27960.768503055657,
                        28022.96485955483,
                        28030.073152594723,
                        28276.702324588,
                        28207.37419373004,
                        28181.78768914216,
                        28194.864572057726,
                        28185.509968749175,
                        28061.452699181464,
                        28064.131795516765,
                        28029.07557290946,
                        28136.789291806756,
                        28088.427031627973,
                        28043.43911097702,
                        28059.8854898523,
                        27929.280784864164,
                        27951.95931334892,
                        27989.51347610333,
                        27866.437547413134,
                        27939.50566925594,
                        27874.404457766424,
                        27899.528059674944,
                        27965.875444715333,
                        28156.56490964856,
                        28087.463899253653,
                        28062.944929115787,
                        27998.075648190174,
                        28070.89754413554,
                        28075.385232439232,
                        28028.726972880282,
                        28012.220258922647,
                        28042.9833864884,
                        28121.824614606016,
                        28071.38923437073,
                        28012.101384307414,
                        28060.134312723243,
                        28023.40401567159
                    ]),
                    priceChangePercentage24HInCurrency: -0.2021476386435856,
                    currentHoldings: 1.5
    )
}
