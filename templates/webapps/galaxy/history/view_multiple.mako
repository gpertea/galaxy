
<%inherit file="/webapps/galaxy/base_panels.mako"/>
<%namespace file="/galaxy_client_app.mako" name="galaxy_client"/>

<%def name="title()">
    ${_( 'Histories' )}
</%def>

## ----------------------------------------------------------------------------
<%def name="stylesheets()">
    ${ parent.stylesheets() }
    <style type="text/css">
    /* reset */
    html, body {
        margin: 0px;
        padding: 0px;
    }
    .contents-loading-indicator {
        /*background: blue;*/
        /*color: white;*/
        text-align: center;
    }
    </style>
</%def>


## ----------------------------------------------------------------------------
<%def name="center_panel()"></%def>

<%def name="javascript_app()">
<script type="text/javascript">
define( 'app', function(){
    require([
        'mvc/history/history-model',
        'mvc/history/multi-panel'
    ], function( HISTORY_MODEL, MULTI_HISTORY ){
        $(function(){
            console.log( bootstrapped.order );
            histories = new HISTORY_MODEL.HistoryCollection( bootstrapped.histories, {
                includeDeleted      : bootstrapped.includingDeleted,
                order               : bootstrapped.order,
                limitOnFirstFetch   : bootstrapped.limit,
                limitPerFetch       : bootstrapped.limit,
                lastFetched         : bootstrapped.limit,
                currentHistoryId    : '${histories[0][ "id" ]}',
            });

            multipanel = new MULTI_HISTORY.MultiPanelColumns({
                el                          : $( '#center' ).get(0),
                histories                   : histories,
            }).render( 0 );
        });
    });
});
</script>
${ galaxy_client.load( app='app', histories=histories,
    includingDeleted=include_deleted_histories, order=order, limit=limit ) }
</%def>
