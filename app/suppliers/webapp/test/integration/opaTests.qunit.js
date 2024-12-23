sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'treinamento/alfa/suppliers/test/integration/FirstJourney',
		'treinamento/alfa/suppliers/test/integration/pages/SupplierList',
		'treinamento/alfa/suppliers/test/integration/pages/SupplierObjectPage'
    ],
    function(JourneyRunner, opaJourney, SupplierList, SupplierObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('treinamento/alfa/suppliers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSupplierList: SupplierList,
					onTheSupplierObjectPage: SupplierObjectPage
                }
            },
            opaJourney.run
        );
    }
);