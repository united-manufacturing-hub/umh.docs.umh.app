docsearch({
    inputSelector: '#searchbar',
    typesenseCollectionName: 'umh.docs',
    typesenseServerConfig: {
        nodes: [{
            host: 'docsearch.umh.app',
            port: '443',
            protocol: 'https'
        }],
        apiKey: 'f81fcLqS2RTx5U858WA2s4rJIQScsMss', // Read-only key
    },
    typesenseSearchParams: {
        per_page: 10,
        query_by: 'hierarchy.lvl0, hierarchy.lvl1, anchor, url, tags, content',
        use_cache: true,
    },
});
