<%-- 
    Document   : searching
    Created on : Nov 26, 2016, 2:15:57 PM
    Author     : shwetimahajan
--%>

<%@page import="java.io.File"
        import="java.io.FileReader"
        import="java.io.IOException"
        import="java.nio.file.Files"
        import="java.nio.file.Paths"
        import="java.util.Date"
        import="org.apache.lucene.analysis.*"
        import="org.apache.lucene.analysis.standard.StandardAnalyzer"
        import="org.apache.lucene.document.Document"
        import="org.apache.lucene.document.Field"
        import="org.apache.lucene.document.TextField"
        import="org.apache.lucene.index.IndexWriter"
        import="org.apache.lucene.index.IndexWriterConfig"
        import="org.apache.lucene.store.Directory"
        import="org.apache.lucene.store.RAMDirectory"
        import="org.apache.lucene.index.*"
        import="org.apache.lucene.queryparser.classic.QueryParser"
        import="org.apache.lucene.search.IndexSearcher"
        import="org.apache.lucene.search.Query"
        import="org.apache.lucene.search.ScoreDoc"
        import="org.apache.lucene.search.TopScoreDocCollector"
        import="org.apache.lucene.store.FSDirectory"
        import="org.json.*"
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Searching Page</title>
    </head>
    <body>
        <%
            String keywords = request.getParameter("keywords");
          
            File dataDir = new File("/Users/shwetimahajan/movies/");
            String results[] = null; 
            StandardAnalyzer stdan = new StandardAnalyzer();
            Query q = new QueryParser( "title", stdan).parse(keywords);
         // 3. search
            int hitsPerPage = 10;
            Directory indDir = FSDirectory.open(Paths.get("/Users/shwetimahajan/luindex/"));
            IndexReader reader = DirectoryReader.open(indDir);
            IndexSearcher searcher = new IndexSearcher(reader);
            TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage);
            searcher.search(q, collector);
            ScoreDoc[] hits = collector.topDocs().scoreDocs;
    
            
         // 4. display results
            for(int i=0;i<hits.length;++i) {
            int docId = hits[i].doc;
            Document d = searcher.doc(docId);
            results[i] = d.get("title");
            System.out.println((i + 1) + "\t" + d.get("title")); // Code to retrieve the file names
            }
            reader.close();
            
            for(int i = 0; i < hits.length ; i ++)
            {
                File f = new File(results[i]);
                //JSONObject obj = new JSON();
            }
     }
     
     
     
            %>
    </body>
</html>
