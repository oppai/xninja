var api_url = API_URL || '/api/new/';
(function(){
    var jWindow = $(window);
    var appendVideo = function(video){
        var appendString = '<a href="/video/'+ video.url +'">'
            + '<img class="xn-thumbnail" src="'+ video.thumbnail +'"/>'
            + '</a>';
        $('#videos').append(appendString);
    };

    var getNewVideos = (function (){
        var isLoading = false;
        var count = 1;
        return function(){
            if ( isLoading == false ) {
                isLoading = true;
                $.getJSON(api_url+count,function(data){
                    for (var i=0; i<data.length ;i++){
                        appendVideo(data[i]);
                    }
                    count ++;
                    isLoading = false;
                });
                ga('send', 'event', 'top', 'paging', count);
            }
        }
    })();

    jWindow.on("load scroll resize",function(){
        var scrollHeight = $(document).height();
        var threthold = scrollHeight - jWindow.height();
        var currentTop = jWindow.scrollTop() + jWindow.height();

        if ( currentTop > threthold ) {
            getNewVideos();
        }
    });

    var jSearch = $('#search_video');
    jSearch.find('button').click(function(){
        var word = jSearch.find('#search_word').val();
        location.href = '/search/'+word;
    });
})();
