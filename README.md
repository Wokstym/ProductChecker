<h1 align="center">Product checker</h1>

<p align="center">

<img src="https://img.shields.io/badge/Flutter-darkblue" />
<img src="https://img.shields.io/badge/blockchain-darkred" />
<img src="https://img.shields.io/badge/web3dart-2.0.0-blue" />
<img src="https://img.shields.io/badge/NFC_in_flutter-2.0.5-red" />
<img src="https://img.shields.io/badge/http-0.12.2-yellow" />

<br/>

ProductChecker is the mobile app for managing product ownership in post supply chain (when the product leaves shop). 

It's built as a **smart contract on ethereum blockchain**, which means it's impossible to counterfeit given product, or to for example cheat while reselling item to another person.

It can be used whereever there is a huge resell market and high posibility of counterfeiting items (for example streetwear market).

### Technologies stack

- Backend
  - Contract is built using Solidity. [Json version](https://github.com/Wokstym/ProductChecker/blob/Readme/assets/ABI.json)
  - Ethereum Kovan testing network is used for hosting our contact
  - Infura for deploying contract to blockchain network
- Frontend
  - Mobile app is built with flutter
  - Web3dart for making calls to Ethereum Kovan network.

### Use cases

* Producer writes productCode and manufacturerCode to NFC tag located on the product through the app
* Supplier or client can 
  * scan NFC tag to verify if product isn't fake (check the current owner, productCode)
  * ship product to the buyer using his/her Ethereum wallet key. 
  * receive product by scanning its' NFC tag

### Demo

<p align="center">
<img src="res/presentation.gif" alt="" data-canonical-src="res/presentation.gif" width="37.5%" height="37.5%" />
</p>

### Running

1. Install your phone drivers
2. Connect your phone with usb debugging enabled 
3. Run `flutter run` in terminal in main folder


### Contributors ✨

<table>
  <tr>
     <td align="center"><a href="https://github.com/nazkord"><img src="https://avatars.githubusercontent.com/u/16627970?s=460&u=e457a3440e6f25b7619ab3f0cef84c61e8bb29d8&v=4" width="100px;" alt=""/><br /><sub><b>Nazar Kordiumov</b></sub></a><br /></td>
    </td>
    <td align="center"><a href="https://github.com/Wokstym"><img src="https://avatars2.githubusercontent.com/u/44115112?s=460&u=2fea6d808fb949060aa499dad3e3365608bb5c40&v=4" width="100px;" alt=""/><br /><sub><b>Grzegorz Poręba</b></sub></a><br />
    </td>
    <td align="center"><a href="https://github.com/wikkam"><img src="https://media-exp1.licdn.com/dms/image/C4D03AQGn42wuvp0dWw/profile-displayphoto-shrink_200_200/0/1603056291705?e=1620864000&v=beta&t=1Zpic0nLNLOdQV_rOdcfxLcA-Zrei5UbDczeAN3B0bA" width="100px;" alt=""/><br /><sub><b>Wiktor Kamiński</b></sub></a><br /></td>
    </td>
    <td align="center"><a href="https://github.com/mzlnk"><img src="https://avatars.githubusercontent.com/u/44784576?s=460&u=14ce204d75bfbc2e5e079f292fd1f5725356e9c7&v=4" width="100px;" alt=""/><br /><sub><b>Marcin Zielonka</b></sub></a><br /></td>
</tr>
</table>
