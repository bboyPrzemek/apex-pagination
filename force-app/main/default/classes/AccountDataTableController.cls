public with sharing class AccountDataTableController extends Pageable {
    public List<Account> accountList {get {return (List<Account>) results;} set;}

    public AccountDataTableController() {
        super();
        this.query = 'SELECT Id, Name from Account where Name like \'przemo%\'';
        this.countQuery = 'SELECT count() from Account where Name like \'przemo%\'';
        this.orderBy = 'NAME';
        runQuery();
    }
}
