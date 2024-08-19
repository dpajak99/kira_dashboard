function KeplrApiWebInterface() {
}

KeplrApiWebInterface.prototype.isExtensionInstalled = function () {
    return !!window.keplr;
}

KeplrApiWebInterface.prototype.sign = async function (stdSignDoc) {
    try {
        const stdSignDocObject = JSON.parse(stdSignDoc);
        const signature = await window.keplr.signDirect('localnet-1', 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx', stdSignDoc);
        return JSON.stringify(signature);
    } catch (e) {
        return e.toString();
    }
}

KeplrApiWebInterface.prototype.getAccount = async function () {
    if (window.keplr) {
        try {
            try {
                await window.keplr.experimentalSuggestChain({
                    chainId: 'localnet-1',
                    chainName: 'KIRA Devnet',
                    rpc: 'http://89.128.117.28:26657',
                    rest: 'http://89.128.117.28:11000',
                    stakeCurrency: {
                        coinDenom: 'UDEV',
                        coinMinimalDenom: 'udev',
                        coinDecimals: 6,
                    },
                    bip44: {
                        coinType: 118,
                    },
                    bech32Config: {
                        bech32PrefixAccAddr: 'kira',
                        bech32PrefixAccPub: 'kirapub',
                        bech32PrefixValAddr: 'kiravaloper',
                        bech32PrefixValPub: 'kiravaloperpub',
                        bech32PrefixConsAddr: 'kiravalcons',
                        bech32PrefixConsPub: 'kiravalconspub',
                    },
                    currencies: [
                        {
                            coinDenom: 'UDEV',
                            coinMinimalDenom: 'udev',
                            coinDecimals: 6,
                        },
                    ],
                    feeCurrencies: [
                        {
                            coinDenom: 'UDEV',
                            coinMinimalDenom: 'udev',
                            coinDecimals: 6,
                        },
                    ],
                });
            } catch (e) {
                console.log(e);
            }
            const offlineSigner = window.keplr.getOfflineSigner('localnet-1');
            const accounts = await offlineSigner.getAccounts();
            return JSON.stringify(accounts);
        } catch (e) {
            return e.toString();
        }
        return 'Keplr is installed';
    } else {
        return 'Keplr is not installed';
    }
}