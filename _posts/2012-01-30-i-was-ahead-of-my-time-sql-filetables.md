---
Title: I was ahead of my time? (SQL FileTables)
Published: 2012-01-30 13:28:00
Excerpt: ""
views:
  - 'a:1:{i:0;s:4:"1011";}'
dsq_thread_id:
  - 'a:1:{i:0;s:10:"3540663421";}'
author:
  - Marc LaFleur
post_date:
  - 2012-01-30 13:28:00
post_excerpt:
  - ""
permalink:
  - /i-was-ahead-of-my-time-sql-filetables/
---
A long time ago in a land far away (ok, 40 minutes west and 20 years ago but lets not quibble over the details) I started playing with Microsoft Access. I loved I (Yes. I said I loved Access. It was the 90's. Things were different then. We shall never speak of this again. Thank you.). In fact, I over-loved it. I shoved everything into it.Â  Application data, logging, security and even files. Yes, I said files. I know, I know. It was a bad idea.

Now fast forward to 2012 and SQL Server 2012 introduces File Tables. That's right, file storage in the database that actually works like I wanted it to. So while you may see my story as a failure to understand basic database principles, I'm choose to believe I was just ahead of my time.

File Tables is an extremely powerful and cool tool in the SQL Server 2012 arsenal. The <a href="http://msdn.microsoft.com/en-us/library/ff929144(v=sql.110).aspx" target="_blank">description from the documentation</a> says it all:
<blockquote>The FileTableÂ feature brings support for the Windows file namespace and compatibility with Windows applications to the file data stored in SQL Server. FileTable lets an application integrate its storage and data management components, and provides integrated SQL Server services - including full-text search and semantic search - over unstructured data and metadata.

In other words, you can store files and documents in special tables in SQL Server called FileTables, but <strong>access them from Windows applications as if they were stored in the file system, without making any changes to your client applications</strong>. [emphasis mine]</blockquote>
The only downside is that apps that use memory-mapped files like Notepad or Paint don't work if SQL Server is on the same machine (this isn't a problem if SQL is remote) but that's a edge-case if you ask me. It is basedÂ on FileStreams so it carries any limitations over from there as well.

Pretty slick stuff.