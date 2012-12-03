<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/">
        <html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <title>ImageJacqui</title>
        
        <link rel="stylesheet" href="../lib/css/basic.css" type="text/css" />
	<link rel="stylesheet" href="../lib/css/galleriffic.css" type="text/css" />
        <link rel="stylesheet" href="../styles.css" type="text/css" />
        
        <script type="text/javascript" src="../lib/js/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="../lib/js/jquery.galleriffic.js"></script>
        <script type="text/javascript" src="../lib/js/jquery.opacityrollover.js"></script>
        <script type="text/javascript" src="../lib/js/jquery.history.js"></script>

        <!-- We only want the thunbnails to display when javascript is disabled -->
        <script type="text/javascript">
            document.write('<style>.noscript { display: none; }</style>');
        </script>    
        
        <script type="text/javascript">
            jQuery(document).ready(function($) {
                $('div.navigation').css({'width' : '360px', 'float' : 'left', 'margin-top' : '6px'});
                $('div.content').css('display', 'block');
                var onMouseOutOpacity = 0.67;
                $('#thumbs ul.thumbs li').opacityrollover({
                        mouseOutOpacity:   onMouseOutOpacity,
                        mouseOverOpacity:  1.0,
                        fadeSpeed:         'fast',
                        exemptionSelector: '.selected'
                });
                var gallery = $('#thumbs').galleriffic({
                    delay:                     2500,
                    numThumbs:                 15,
                    preloadAhead:              10,
                    enableTopPager:            true,
                    enableBottomPager:         true,
                    maxPagesToShow:            7,
                    imageContainerSel:         '#slideshow',
                    controlsContainerSel:      '#controls',
                    captionContainerSel:       '#caption',
                    loadingContainerSel:       '#loading',
                    renderSSControls:          true,
                    renderNavControls:         true,
                    playLinkText:              'Play Slideshow',
                    pauseLinkText:             'Pause Slideshow',
                    prevLinkText:              '&lt; Previous Photo',
                    nextLinkText:              'Next Photo &gt;',
                    nextPageLinkText:          'Next &gt;',
                    prevPageLinkText:          '&lt; Prev',
                    enableHistory:             true,
                    autoStart:                 false,
                    syncTransitions:           true,
                    defaultTransitionDuration: 900,
                    onSlideChange:             function(prevIndex, nextIndex) {
                            // 'this' refers to the gallery, which is an extension of $('#thumbs')
                            this.find('ul.thumbs').children()
                                    .eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
                                    .eq(nextIndex).fadeTo('fast', 1.0);
                    },
                    onPageTransitionOut:       function(callback) {
                            this.fadeTo('fast', 0.0, callback);
                    },
                    onPageTransitionIn:        function() {
                            this.fadeTo('fast', 1.0);
                    }
                });
                function pageload(hash) {
                        // alert("pageload: " + hash);
                        // hash doesn't contain the first # character.
                        if(hash) {
                                $.galleriffic.gotoImage(hash);
                        } else {
                                gallery.gotoIndex(0);
                        }
                }

                $.historyInit(pageload, "advanced.html");

                $("a[rel='history']").live('click', function(e) {
                    if (e.button != 0) return true;
                   
                    var hash = this.href;
                    hash = hash.replace(/^.*#/, '');
                    $.historyLoad(hash);

                    return false;
                });
            });
        </script>
    </head>
    <body>
        <xsl:apply-templates /> 
    </body>
    </html>
    </xsl:template>
    
    <xsl:template match="album">
        <div id="container">
            <div class="menuItems"><a href="../index.html">&lt; Back to Galleries</a>&#160;|&#160;<a href="../howToPurchase.html">How to Purchase</a>&#160;|&#160;<a href="../aboutMe.html">About Jacqui</a></div>
	    <h1><xsl:value-of select="@name" /> Gallery</h1>
            <!--<a href="../index.html">Back to Galleries</a>-->
            <!-- Start Advanced Gallery Html Containers -->
            <div id="thumbs" class="navigation">
                <ul class="thumbs noscript">
                    
                <xsl:apply-templates />
                    
                </ul>
            </div>
            <div id="gallery" class="content">
                <div id="controls" class="controls"></div>
                <div class="slideshow-container">
                        <div id="loading" class="loader"></div>
                        <div id="slideshow" class="slideshow"></div>
                </div>
                <div id="caption" class="caption-container"></div>
            </div>
            <!-- End Advanced Gallery Html Containers -->
            <div style="clear: both;"></div>
	</div>
    </xsl:template>
    
    <xsl:template match="photo">
        <li>
            <a class="thumb">
                <xsl:attribute name="name">
                    <xsl:value-of select="caption" />
                </xsl:attribute>
                <xsl:attribute name="href">../images/big/<xsl:value-of select="@id" />.jpg</xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:value-of select="caption" />
                </xsl:attribute>
                
                
                <img src="images/small/2007120.jpg" alt="Egyptian greeting">
                <xsl:attribute name="src">../images/small/<xsl:value-of select="@id" />.jpg</xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="caption" />
                </xsl:attribute>
                </img>
            </a>
            <div class="caption">
                <div class="image-title"><xsl:value-of select="caption" /></div>
                <div class="image-desc">Photo number: <xsl:value-of select="@id" /></div>
            </div>
        </li>
    </xsl:template>

</xsl:stylesheet>