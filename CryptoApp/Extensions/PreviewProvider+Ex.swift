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
    private init() { }
    
    // view model do mockowania
    let homeVM = HomeViewModel(
        coinDataService: MockCoinDataService(),
        marketDataService: MockMarketDataService()
    )
    
    // przykładowe statystyki
    let stat1 = Statistic(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let stat2 = Statistic(title: "Total Volume", value: "$1.23Tr")
    let stat3 = Statistic(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)
    
    // przykładowy market data
    let globalData = GlobalData(
        data: MarketData(
            totalMarketCap: ["usd": 5547935811415.6528],
            totalVolume: ["usd": 33818548707.57213],
            marketCapPercentage: ["btc": 77.732472148476724],
            marketCapChangePercentage24hUsd: 0.7867739393124703
        )
    )
    
    // przykładowe coiny do mockowania
    let bitcoin = Coin(id: "bitcoin",
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
                    currentHoldings: nil
    )
    let ethereum = Coin(id: "ethereum",
                    symbol: "eth",
                    name: "Ethereum",
                    image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
                    currentPrice: 1823.68,
                    marketCap: 224376525539,
                    marketCapRank: 2,
                    fullyDilutedValuation: 224376525539,
                    totalVolume: 7584185188,
                    high24H: 1846.77,
                    low24H: 1788.68,
                    priceChange24H: 23.76,
                    priceChangePercentage24H: 1.31997,
                    marketCapChange24H: 3168488181,
                    marketCapChangePercentage24H: 1.43236,
                    circulatingSupply: 122962329.774818,
                    totalSupply: 122962329.774818,
                    maxSupply: 0.0,
                    ath: 4878.26,
                    athChangePercentage: -62.574,
                    athDate: "2021-11-10T14:24:19.604Z",
                    atl: 0.432979,
                    atlChangePercentage: 421569.01355,
                    atlDate: "2015-10-20T00:00:00.000Z",
                    lastUpdated: "2023-05-15T22:15:30.447Z",
                    sparklineIn7D: SparklineIn7D(price: [
                        1849.882585422057,
                        1830.7839770775863,
                        1837.1023679430862,
                        1841.5594945512294,
                        1843.8516577529392,
                        1845.5912812743247,
                        1849.2886295625283,
                        1842.8599165910425,
                        1849.5517757913665,
                        1844.7500190339872,
                        1845.1161563513624,
                        1843.698540645371,
                        1842.8927864870668,
                        1836.9201889775509,
                        1844.451732203408,
                        1841.1468810318897,
                        1840.6656148660709,
                        1844.5549585387935,
                        1847.974593291958,
                        1847.8306426204786,
                        1841.8015118851793,
                        1842.8313653114792,
                        1844.85084459849,
                        1842.119774231482,
                        1848.6496765583581,
                        1848.5485872049057,
                        1849.8533262950614,
                        1849.529076103948,
                        1846.6490200043859,
                        1843.9493797991183,
                        1848.098170848278,
                        1852.4132455656518,
                        1851.219557812243,
                        1846.3524697903133,
                        1844.6645731312353,
                        1845.602122104932,
                        1844.8954521964474,
                        1839.8978306069723,
                        1840.630419158116,
                        1840.447578047617,
                        1840.4981356953353,
                        1843.5152312643138,
                        1850.2679907368022,
                        1880.1333040266104,
                        1873.0218619325947,
                        1877.053199849086,
                        1875.1899556058358,
                        1876.3491308517428,
                        1827.6528028611992,
                        1837.1699418083083,
                        1851.0276994973544,
                        1859.2394045802769,
                        1839.78829277706,
                        1844.6031343898367,
                        1842.865558834664,
                        1835.3990720974377,
                        1836.666237643212,
                        1833.7315018230474,
                        1828.31574820347,
                        1830.8133864129693,
                        1829.924489696784,
                        1831.3715376922323,
                        1832.9598751823496,
                        1820.226862159175,
                        1823.0611071452204,
                        1823.3872112388028,
                        1822.1132074316345,
                        1821.2518178625428,
                        1811.822857096173,
                        1793.313958958069,
                        1809.166099188243,
                        1806.8425425989303,
                        1784.5707333191956,
                        1787.6335137926865,
                        1784.1706988145647,
                        1797.9331679311263,
                        1796.9208343526063,
                        1791.5667660348606,
                        1798.0719455262627,
                        1800.122020791133,
                        1790.297160995388,
                        1782.4975033019336,
                        1766.2621263936637,
                        1767.6296217256427,
                        1758.7607779201728,
                        1755.818066975867,
                        1761.5149238608747,
                        1760.3156339482857,
                        1767.1204375298132,
                        1768.3749887255742,
                        1767.823164971475,
                        1771.7886679458798,
                        1773.7800776803715,
                        1773.429038612865,
                        1766.7362894922933,
                        1769.1996045820672,
                        1774.1136298459421,
                        1770.496936093953,
                        1771.2521481594895,
                        1788.9872896062066
                    ]),
                    priceChangePercentage24HInCurrency: 1.3199668109486598,
                    currentHoldings: nil
    )
    let tether = Coin(id: "tether",
                    symbol: "usdt",
                    name: "Tether",
                    image: "https://assets.coingecko.com/coins/images/325/large/Tether.png?1668148663",
                    currentPrice: 1,
                    marketCap: 82881248832,
                    marketCapRank: 3,
                    fullyDilutedValuation: 82881248832,
                    totalVolume: 16604825825,
                    high24H: 1.005,
                    low24H: 0.997021,
                    priceChange24H: -0.000043820793518057,
                    priceChangePercentage24H: -0.00438,
                    marketCapChange24H: 11324600,
                    marketCapChangePercentage24H: 0.01367,
                    circulatingSupply: 82807235429.0672,
                    totalSupply: 82807235429.0672,
                    maxSupply: 0.0,
                    ath: 1.32,
                    athChangePercentage: -24.41137,
                    athDate: "2018-07-24T00:00:00.000Z",
                    atl: 0.572521,
                    atlChangePercentage: 74.68522,
                    atlDate: "2015-03-02T00:00:00.000Z",
                    lastUpdated: "2023-05-15T22:15:00.384Z",
                    sparklineIn7D: SparklineIn7D(price: [
                        1.000040153551333,
                        1.001441350636579,
                        1.0010404616788295,
                        1.001760804168129,
                        1.0009201113224275,
                        1.0008933946822607,
                        1.0005322691400187,
                        1.0010280421373061,
                        1.0009389413502647,
                        1.0007879118854361,
                        1.000935263193714,
                        1.0006226164154381,
                        0.9984782017153309,
                        0.9999672489751407,
                        0.9999344955553494,
                        1.0000285070975714,
                        1.000040915068233,
                        1.000756671478843,
                        1.00020573933954,
                        0.9999385729661019,
                        0.9997513557330898,
                        1.0022157854510096,
                        0.998007085283602,
                        1.0011509810948307,
                        1.0005481959992248,
                        1.0011983476909443,
                        1.000270735737807,
                        1.00010239149623,
                        1.0004525412819145,
                        1.0005549557029398,
                        1.0011339122560803,
                        1.0010835553616675,
                        1.0009338483020005,
                        1.000416378108239,
                        1.0001376908311275,
                        1.0004765867451695,
                        1.0000420625359006,
                        1.0002570191034483,
                        1.0014857870181844,
                        1.0002999182601382,
                        1.0003900444359566,
                        1.0008877192508039,
                        1.0018732563728765,
                        0.9999563177942313,
                        1.0011484459523448,
                        1.0009232287849106,
                        1.0017520607900543,
                        1.0017047440075788,
                        1.0013115353762523,
                        1.0006401938753735,
                        1.0006730063227467,
                        1.001985520908966,
                        1.0013483685509246,
                        0.9997730914912693,
                        1.0007381827670578,
                        1.0013479939900898,
                        1.000664129651992,
                        1.0009828627990605,
                        1.0009237023803912,
                        0.9996488991752828,
                        1.0007220006705353,
                        1.0017114906256381,
                        1.0002594583061581,
                        1.0003885192735085,
                        1.0002274270344151,
                        1.000739185723746,
                        1.0011667910417865,
                        0.9999544081113271,
                        0.9994378150139195,
                        1.0026288279928253,
                        1.0012675125200654,
                        1.0018505589312716,
                        1.0003233622132757,
                        1.0000118126187691,
                        1.0011793533961735,
                        1.0009746476972299,
                        1.000543990091525,
                        0.9999926442450879,
                        1.0006814648261164,
                        1.0003996445112082,
                        1.000254239497488,
                        1.0011292833308147,
                        0.9996553314963786,
                        1.0014260444659882,
                        1.0003682850334619,
                        1.0005251566942457,
                        0.999586036613178,
                        1.000375727213364,
                        1.0002368535190007,
                        1.0010695214140592,
                        0.9999676178695696,
                        0.9984278050010935,
                        1.0023265226467362,
                        1.0005487638731925,
                        1.0003723387541332,
                        1.0005985319570323,
                        0.999993863429984,
                        1.0037691044724415,
                        1.00083708477146,
                        0.9984509928639685
                    ]),
                    priceChangePercentage24HInCurrency: -0.004381612635176562,
                    currentHoldings: nil
    )
}
