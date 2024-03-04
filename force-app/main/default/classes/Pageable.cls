public virtual with sharing class Pageable {

    public String query {get;set;}
    public String countQuery {get;set;}
    public String orderBy {get;set;}
    public String sortOrder {get;set;}
    public Integer recordLimit {get;set;}
    public Integer offset {get;set;}
    public Integer resultCount {get;set;}
    public List<SObject> results {get;set;}

    public Integer pages {
        get {
            return (Integer) Math.ceil(Double.valueOf(resultCount) / Double.valueOf(recordLimit)) ;
        }
        private set;
        }

    public Pageable(){
        recordLimit = 10;
        sortOrder = 'DESC';
        offset = 0;
    }

    public void runQuery(){
        resultCount = getCount();
        results = getResults();
    }

    private List<SObject> getResults(){
        String queryString  = this.query;
        queryString += this.orderBy != null ? ' ORDER BY ' + this.orderBy + ' ' + this.sortOrder  : '';
        queryString += ' LIMIT ' + this.recordLimit;
        queryString += ' OFFSET ' + this.offset;
        return Database.query(queryString);
    }

    private Integer getCount(){
        return Database.countQuery(countQuery);
    }

    public void next(){
        this.offset += this.recordLimit;
        runQuery();
    }

    public void previous(){
            this.offset = this.offset == 0 ? 0: this.offset - this.recordLimit;
            runQuery();
    }

    public void last(){
        this.offset = (pages - 1) * recordLimit;
        runQuery();
    }

    public void first(){
        this.offset = 0;
        runQuery();
    }

    public Boolean getHasPrevious(){
        return this.offset > 0;
    }

    public Boolean getHasNext(){
        return this.offset < (pages - 1) * recordLimit;
    }
}