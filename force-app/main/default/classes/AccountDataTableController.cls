public with sharing class AccountDataTableController extends Pageable {

    public List<Account> accountList {
        get {
            return (List<Account>) results;
        }
        set;
    }

    public AccountDataTableController() {
        super();
        this.query = 'SELECT Id, Name from Account where Name like \'Test%\'';
        this.countQuery = 'SELECT count() from Account where Name like \'Test%\'';
        this.orderBy = 'NAME';
        runQuery();
    }
}
