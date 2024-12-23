using OrderService as service from '../../srv/order-service';

annotate service.Supplier with {
    supplierb1_code @Common: {
        Text           : supplierb1.name,
        TextArrangement: #TextFirst,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            Label         : 'Fornecedor B1',
            CollectionPath: 'SupplierB1',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: supplierb1_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                }

            ]
        },
    };
};
