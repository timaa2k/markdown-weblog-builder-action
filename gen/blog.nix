{ attrsToDirs', render, renderAll }:

with rec {
  contents  = renderAll "blog";
  blogPages = attrsToDirs' "blogPages" contents;
};

{
  blog = contents // {
    "index.html" = render {
      name        = "index.html";
      vars        = { inherit blogPages; };
      file        = ../../blog.md;
      TO_ROOT     = "..";
      SOURCE_PATH = "blog.md";
    };
  };

  "index.html" = render {
    name        = "index.html";
    vars        = { inherit blogPages; };
    file        = ../../index.md;
    TO_ROOT     = ".";
    SOURCE_PATH = "index.md";
  };
}
