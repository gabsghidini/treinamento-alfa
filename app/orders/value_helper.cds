using OrderService as service from '../../srv/order-service';

annotate service.OrderHeader with {
    status_code   @Common: {
        Text           : status.name,
        TextArrangement: #TextOnly,
        ValueListWithFixedValues,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            Label         : 'Status',
            CollectionPath: 'StatusOrder',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: status_code,
                ValueListProperty: 'code',
            }, ]
        },
    };
    supplier_code @Common: {
        Text           : supplier.businessName,
        TextArrangement: #TextLast,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            Label         : 'Consulta de Fornecedores',
            CollectionPath: 'Supplier',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: supplier_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'businessName',
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: supplier_cnpj,
                    ValueListProperty: 'cnpj',
                },
            ],
        },
    };
};

annotate service.OrderProduct with {
    product_code @Common: {ValueList: {
        $Type         : 'Common.ValueListType',
        Label         : 'Consulta de Produtos',
        CollectionPath: 'Product',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: product_code,
                ValueListProperty: 'code',
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: product_name,
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: unitCost,
                ValueListProperty: 'price',
            },
        ],
    }, };
};
