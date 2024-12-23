using {treinamento.alfa as db} from '../db/schema';


service OrderService {
    @odata.draft.enabled
    entity Product     as projection on db.Product;

    @odata.draft.enabled
    entity Supplier    as projection on db.Supplier;

    @odata.draft.enabled
    entity OrderHeader as
        projection on db.OrderHeader {
            *,
            @readonly supplier.cnpj as supplier_cnpj,
        }
        actions {
            @(
                // atualiza a UI dps da ação
                cds.odata.bindingparameter.name: '_it',
                Common.SideEffects             : {TargetProperties: ['_it/status_code'], },
                Core.OperationAvailable        : {$edmJson: {$Eq: [
                    {$Path: 'status_code'},
                    'P',
                ]}}
            )

            action approveOrder(
                                @(
                                    Label:'Status',
                                    Common.ValueList.entity:'StatusOrder', // Para habilitar o Value Help
                                    Common.ValueList.CollectionPath:'StatusOrder'
                                )
                                status_code : String(1) not null @title:'Status' );
        };

    entity SupplierB1  as projection on db.SupplierB1;

}
