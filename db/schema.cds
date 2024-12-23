using {
    sap.common.CodeList,
    cuid,
    managed
} from '@sap/cds/common';
using {API_B1_SERVICE_LAYER as sapb1} from '../srv/external/API_B1_SERVICE_LAYER';

namespace treinamento.alfa;

type Code : String(10) @(title: 'Code');

@cds.autoexpose
aspect code : cuid {
    code : Code not null;
}

entity Product : code, managed {
    name        : String(50)      @title         : 'Nome';
    description : String(100)     @title         : 'Descrição';
    price       : Decimal(10, 2)  @title         : 'Preço'  @Common.IsCurrency;
    image       : LargeBinary     @Core.MediaType: 'image/png';
}

entity Supplier : code, managed {
    businessName    : String(100) @title: 'Razão Social';
    fantasyName     : String(100) @title: 'Nome Fantasia';
    cnpj            : String(14)  @title: 'CNPJ';

    supplierb1      : Association to one SupplierB1
                          on supplierb1.code = supplierb1_code;
    supplierb1_code : String(100) @title: 'Supplier B1 Code';
}

@cds.autoexpose
entity StatusOrder : CodeList {
    key code        : String(1)  @Common.Text: name  @Common.TextArrangement: #TextOnly;
        criticality : Integer;
}

@assert.unique: {documentNumber: [documentNumber]}
entity OrderHeader : cuid, managed {
    @mandatory documentNumber       : String(10) not null   @title: 'Document Number';
    @mandatory documentDate         : Date default $now     @title: 'Document Date';
    @mandatory expectedDeliveryDate : Date default $now     @title: 'Expected Delivery Date';
    observation                     : String                @title: 'Observation';
    @mandatory supplier_code        : Code                  @title: 'Supplier Code';
    supplier                        : Association to one Supplier
                                          on supplier.code = supplier_code;

    status                          : Association to one StatusOrder
                                          on status.code = status_code;
    @readonly status_code           : String(1) default 'P' @title: 'Status';

    _items                          : Composition of many OrderProduct
                                          on _items.order = $self;


    @readonly total                 : Decimal(12, 2)        @title: 'Total'  @Common.IsCurrency;
}

entity OrderProduct : cuid {
    key order                  : Association to one OrderHeader;
        product_code           : String(10);
        product                : Association to one Product
                                     on product.code = product_code;

        @readonly product_name : String(100);
        unitCost               : Decimal(12, 2);
        quantity               : Integer default 1;
        @readonly total        : Decimal(12, 2);

}

entity SupplierB1 as
    projection on sapb1.BusinessPartners {
        key CardCode as code,
            CardName as name,
    };
