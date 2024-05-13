docsearch({
    inputSelector: '#searchbar',
    typesenseCollectionName: 'umh.docs',
    typesenseServerConfig: {
        nodes: [{
            host: '35n7gptj4h8z0dyop-1.a1.typesense.net',
            port: '443',
            protocol: 'https'
        }],
        apiKey: 'FKNWuSWO8u07dxyVKnFHNPwpeAIxvPKj', // Read-only key
    },
    typesenseSearchParams: {
        per_page: 10,
        query_by: 'hierarchy.lvl0, hierarchy.lvl1, anchor, url, tags, content',
        use_cache: true,
    },
});
