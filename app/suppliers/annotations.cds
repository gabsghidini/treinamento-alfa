using OrderService as service from '../../srv/order-service';

annotate service.Supplier with @(
    UI.HeaderInfo                : {
        TypeName      : 'Supplier',
        TypeNamePlural: 'Suppliers',
        TypeImageUrl  : 'sap-icon://supplier',
        Title         : {Value: businessName, },
        Description   : {Value: fantasyName, },
    },
    UI.SelectionFields           : [
        businessName,
        fantasyName,
    ],
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Código',
                Value: code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Razão Social',
                Value: businessName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Nome Fantasia',
                Value: fantasyName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'CNPJ',
                Value: cnpj,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Código B1',
                Value: supplierb1_code,
            }
        ]
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'Código',
            Value: code,
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Razão Social',
            Value                : businessName,
            ![@HTML5.CssDefaults]: {width: 'auto', },
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Nome Fantasia',
            Value                : fantasyName,
            ![@HTML5.CssDefaults]: {width: 'auto', },
        },
        {
            $Type: 'UI.DataField',
            Label: 'CNPJ',
            Value: cnpj,
        }
    ],
);
