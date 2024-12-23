using OrderService as service from '../../srv/order-service';

annotate service.Product with {
    ID          @UI.Hidden       : true;
    description @UI.MultiLineText: true;
}

annotate service.Product with @(
    UI.HeaderInfo                : {
        TypeName      : 'Product',
        TypeNamePlural: 'Products',
        TypeImageUrl  : 'sap-icon://product',
        Title         : {Value: name, },
        Description   : {Value: description, },
        ImageUrl      : image,
    },
    UI.SelectionFields           : [
        name,
        price,
    ],
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Imagem do Produto',
                Value: image,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Código',
                Value: code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Nome',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Descrição',
                Value: description,
            },
        ],
    },
    UI.FieldGroup #GroupPrice    : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Label: 'Preço',
            Value: price,
        }, ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Detalhes',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'PriceFacets',
            Label : 'Precificação',
            Target: '@UI.FieldGroup#GroupPrice',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'Imagem do Produto',
            Value: image,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Código',
            Value: code,
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Nome',
            Value                : name,
            ![@HTML5.CssDefaults]: {width: '16rem', },
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Descrição',
            Value                : description,
            ![@HTML5.CssDefaults]: {width: 'auto', },
        },
        {
            $Type: 'UI.DataField',
            Label: 'Preço',
            Value: price,
        },
    ],
);
