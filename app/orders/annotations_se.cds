using OrderService as service from '../../srv/order-service';

annotate service.OrderProduct @Common.SideEffects #UpdateTotal: {
    SourceProperties: [
        'quantity',
        'unitCost',
    ],
    TargetProperties: ['total', ],
};

annotate service.OrderHeader @Common.SideEffects #UpdateTotalHeader: {
    SourceEntities  : [_items],
    TargetProperties: ['total'],
};
