sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'treinamento/alfa/products/test/integration/FirstJourney',
		'treinamento/alfa/products/test/integration/pages/ProductList',
		'treinamento/alfa/products/test/integration/pages/ProductObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductList, ProductObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('treinamento/alfa/products') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductList: ProductList,
					onTheProductObjectPage: ProductObjectPage
                }
            },
            opaJourney.run
        );
    }
);