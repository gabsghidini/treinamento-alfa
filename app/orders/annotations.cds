using OrderService as service from '../../srv/order-service';
using from '../../db/schema';

annotate service.OrderHeader with {
    ID          @UI.Hidden       : true;
    observation @UI.MultiLineText: true;
}

annotate service.OrderHeader with @(
    UI.HeaderInfo                : {
        TypeName      : 'Order',
        TypeNamePlural: 'Orders',
        TypeImageUrl  : 'sap-icon://order-status',
        Title         : {Value: documentNumber, },
        Description   : {Value: observation, },
    },
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type                : 'UI.DataField',
                Label                : 'Número do Documento',
                Value                : documentNumber,
                ![@HTML5.CssDefaults]: {width: '12rem', },

            },
            {
                $Type: 'UI.DataField',
                Label: 'Data do Documento',
                Value: documentDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Data de Entrega',
                Value: expectedDeliveryDate,
            },
            {
                $Type      : 'UI.DataField',
                Label      : 'Status',
                Value      : status_code,
                Criticality: status.criticality,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Código do Fornecedor',
                Value: supplier_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'CNPJ do Fornecedor',
                Value: supplier_cnpj,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Observação',
                Value: observation,

            },
            {
                $Type: 'UI.DataField',
                Label: 'Total',
                Value: total,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            ID    : 'Items',
            Target: '_items/@UI.LineItem#Items',
        },
    ],
    UI.LineItem                  : [
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Aprovar',
            Action: 'OrderService.approveOrder',
        },
        {
            $Type: 'UI.DataField',
            Label: 'Número do Documento',
            Value: documentNumber,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Data do Documento',
            Value: documentDate,
        },
        {
            $Type            : 'UI.DataField',
            Label            : 'Data de Entrega',
            Value            : expectedDeliveryDate,
            ![@UI.Importance]: #Low,
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Status',
            Value                : status_code,
            Criticality          : status.criticality,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: 'auto', },
        },
        {
            $Type            : 'UI.DataField',
            Label            : 'Total',
            Value            : supplier_code,
            ![@UI.Importance]: #High,
        },
    ],
);

annotate service.OrderProduct with @(
    UI.LineItem #Items  : [
        {
            $Type                : 'UI.DataField',
            Label                : 'Produto',
            Value                : product_code,
            ![@HTML5.CssDefaults]: {width: 'auto', },
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Nome',
            Value                : product_name,
            ![@HTML5.CssDefaults]: {width: 'auto', },
        },
        {
            $Type: 'UI.DataField',
            Label: 'Quantidade',
            Value: quantity,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Preço Unitário',
            Value: unitCost,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Total',
            Value: total,
        },
    ],
    UI.FieldGroup #Items: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Produto',
                Value: product_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Nome',
                Value: product_name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quantidade',
                Value: quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Preço Unitário',
                Value: unitCost,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Total',
                Value: total,
            },
        ],
    }
);
