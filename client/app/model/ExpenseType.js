Ext.define('Cooperativista.model.ExpenseType', {
    extend: 'Cooperativista.model.Base',

    fields: [
        { name: 'id', type: 'auto' },
        { name: 'expense_description', type: 'auto' },
        { name: 'expense_code', type: 'auto' },
        { name: 'status', type: 'auto' }

    ],
    proxy: {
        type: 'rest',
        api: {
            create: 'sqlite://expense_types_add',
            read: 'sqlite://expense_types_load',
            update: 'sqlite://expense_types_update',
            destroy: 'sqlite://expense_types_delete'
        },
        reader: {
            type: 'json',
            rootProperty: 'data'
        }/*,
        extraParams: {
            status: 1
        }*/

    }
});
