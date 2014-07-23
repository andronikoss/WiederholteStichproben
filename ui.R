

library(shiny)

shinyUI( fluidPage(withMathJax(),
    titlePanel(span("Wahrscheinlichkeitsverteilung der Kleinstquadrat-Schätzer",
                    style="color:white"),
               windowTitle="KQ-Schätzer"),
    
		sidebarLayout(position="right",
            sidebarPanel(
                wellPanel(style = "background-color: #FFFFFF;",  h5("Bedienfenster"),
                             
                sliderInput('Number.of.Observation', 'Beobachtungsumfang \\( (T) \\)',
                            value=3, min=3, max=150, step=1,),
                sliderInput('sigma', 'Varianz der Störgrößen \\( ({\\sigma}^2) \\)',
                            value=2, min=0, max=10, step=0.1,),
                div(sliderInput('pick', 'Stichproben \\( (S) \\)',
                    value=1, min=1, max=100, step=1,
                    animate=animationOptions(interval=1000,
                    playButton = HTML('<p align="right"><button type="button" class="btn btn-small btn-primary">
                                    <span class="icon-play"></span> Start </button></p>'),
                    pauseButton = HTML('<p align="right"><button type="button" class="btn btn-small btn-primary">
                                    <span class="icon-pause"></span> Pause </button></p>') ))),
                             
                    selectInput("select", label = "Darstellung der Punktwolke", 
                                choices = list("Einzeln", "Gemeinsam"), 
                                selected = "Einzeln"),
                    checkboxInput("checkbox", label = "Wahrscheinlichkeitsverteilung", value = F) ,
                    br(),
                    shinysky::actionButton('action', 'Stichprobenerzeugung', styleclass='success'),
                    downloadButton('downloadPlot', 'Grafik herunterladen')),
                             
                    br(),
                           
                             
                wellPanel(p(strong("Redaktion"), style='margin-bottom:1px;color:black;'),
                            HTML("<p style='margin-bottom:1px;color:black;'>Programmierung: Andranik Stepanyan</p>"),
                            p("Text: Ludwig von Auer", style="color:black"),
                            HTML("<a , style='margin-bottom:1px;color:black;' href = 'https://www.uni-trier.de/index.php?id=50126' target='_blank'>Professur für Finanzwissenschaft</a>"),
                            p("Fachbereich IV - Volkswirtschaftslehre", style = 'margin-bottom:1px;color:black;'),
                            p("Universität Trier", style="color:black"),
                            p(strong("Lehrbuch"), style = 'margin-bottom:1px; color:black;'),
                            HTML("<p style = 'color:black;'>Auer, Ludwig <a href = 'https://www.uni-trier.de/index.php?id=15929' target='_blank'><img src='buch.jpg' style='float: right;'></a>von (2013),
                                 <a href = 'https://www.uni-trier.de/index.php?id=15929' target='_blank' style='color:black'>Ökonometrie - eine Einführung,<br>
                                 6. Auflage, Springer-Gabler<a/> </p>"),
                         
                            br(),
                            br(),
                            HTML('<div class="btn-group dropup">
                                <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#">
                                Weitere Animationen
                                <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/Stoergroessen/" target="_blank">&nbsp; Störgrößen</a></p>
                                <p style="margin-bottom:1px;color:black;">&nbsp; KQ-Schätzer</p>
                                <a href="https://oekonometrie.shinyapps.io/Intervallschaetzer/" target="_blank">&nbsp; Intervallschätzer</a>
                                <p style="margin-bottom:1px;" ><a href="https://oekonometrie.shinyapps.io/t-Test/" target="_blank">&nbsp; t-Test</a></p>
                                <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/Ftest/" target="_blank">&nbsp; F-Test versus t-Test</a></p>
								
                                </ul>
                                </div>')),
                list(tags$head(tags$style("body {background-color: #6d6d6d; }"))))
                
                    
                       
                ,
    
		mainPanel(wellPanel(wellPanel(style = "background-color: #FFFFFF;",
                                      plotOutput("densityPlot", height="440px"))),
                         
		wellPanel(style = "background-color: #DEEBF7;", tabsetPanel(type = "pills",
                                     
tabPanel(h5("Was wird veranschaulicht?"),

p("Jede wiederholte Stichprobe erzeugt eine neue Punktwolke und damit neue 
KQ-Schätzwerte \\( \\hat{\\alpha} \\) und \\( \\hat{\\beta} \\).  In der 
Animation können Sie den Einfluss der Störgrößenvarianz und des 
Beobachtungsumfangs auf diese KQ-Schätzwerte studieren.", style="color:black" ) ),

tabPanel(h5("Was zeigt die Anfangseinstellung?"), p("Die Animation greift das 
Trinkgeld-Beispiel des Lehrbuches auf. Für jeden Gast \\( t \\) wird das 
beobachtete Trinkgeld \\( y_{t} \\) durch den Rechnungsbetrag \\( x_{t} \\) 
erklärt: $$y_{t}=α+βx_{t}+u_{t}$$

Der Animation sind die wahren Parameterwerte \\( \\alpha = 0,2 \\)   und  \\( 
\\beta =0,13 \\) sowie die Rechungsbeträge \\( x_{1}=10 \\), \\( x_{2}=30 \\) 
und \\( x_{3}=50 \\) zugrunde gelegt . Ferner wurden normalverteilte 
Störgrößen \\( u_{t} \\) mit Erwartungswert \\( E(u_{t})=0 \\) unterstellt. In
der Anfangseinstellung beträgt die Störgrößenvarianz \\( {\\sigma}^2 = 2 \\) 
und der Beobachtungsumfang (Anzahl der Beobachtungen pro Stichprobe) beträgt 
\\( T=3 \\).",

HTML("<ul><li style='color:black;'>Die <strong>linke Grafik</strong> zeigt die Punktwolke, welche 
auf der Grundlage dieser Parameterwerte in einem Zufallsprozess erzeugt wurde.
Die rote Linie ist die resultierende KQ-Regressionsgerade.</li></ul>"), 
HTML("<ul><li style='color:black;'>Die rote Gerade der <strong>mittleren Grafik</strong> markiert 
den \\( \\hat{\\beta} \\)-Wert (Steigung) dieser Regressionsgerade, die 
schwarze Gerade den wahren Wert \\( \\beta = 0,13 \\) . Die graue Fläche kann 
zunächst noch ignoriert werden.</li></ul>"),
HTML("<ul><li style='color:black;'>Die rote Gerade der
<strong>rechten Grafik</strong> markiert den \\( \\hat{\\alpha} \\)-Wert der 
Regressionsgerade (Schnittpunkt mit der vertikalen Achse) und die schwarze 
Gerade den wahren Wert \\( \\alpha = 0,2 \\).</li></ul>"), style="color:black" 

)),

tabPanel(h5("Benutzungshinweise"), p("Im Bedienfenster sehen Sie verschiedene 
Schieber",
HTML("<img src='slider.jpg'>"), ", mit denen Sie die zugrunde 
liegenden Parameterwerte verändern können. Klicken Sie dafür mit der linken 
Maustaste auf den entsprechenden Schieber und bewegen sie ihn nach rechts oder
links.",
HTML("<p style ='color:black;'>Mit dem Stichproben-Schieber stellen Sie ein, wie viel 
wiederholte Stichproben \\( S \\) erzeugt werden sollen. Jeder wiederholten 
Stichprobe liegen die gleichen Rechnungsbeträge und die gleichen 
Regressionsparameter ( \\( \\alpha = 0,2 \\) und \\( \\beta =0,13 \\)) 
zugrunde. Die zufallsabhängigen Störgrößen \\( u_{t} \\) sorgen dafür, dass 
die Trinkgeldbeträge \\( y_{t} \\) in jeder wiederholten Stichprobe dennoch 
unterschiedlich ausfallen. Es werden folglich \\( S \\) verschiedene 
Punktwolken und damit \\( S \\) verschiedene KQ-Regressionsgeraden 
erzeugt.</p>"), HTML("<p style ='color:black;'>Wenn Sie im Bedienfenster das Feld
<img src='stich.jpg'> anklicken, werden \\( S \\) neue Stichproben erzeugt und 
die alten werden gelöscht.</p>"),
HTML('<p style ="color:black;">Wie die \\( S \\) Stichproben in der 
linken Grafik dargestellt werden sollen, legen Sie selbst fest. Im Bedienfeld 
haben Sie unter der Überschrift "Darstellung" die Wahl zwischen <img 
src="Einzeln.jpg"> und <img src="Gemeinsam.jpg"> Die Voreinstellung ist <img 
src="Einzeln.jpg">'),
HTML("<dl class='dl-horizontal'> <dt><img src='Einzeln.jpg'></dt> <dd style ='color:black;'>In der 
linken Grafik wird die erste der \\( S \\) 
Stichproben einzeln dargestellt. Die Grafik zeigt die Punktwolke und die 
Regressionsgerade dieser Stichprobe. Klicken Sie nun auf",
HTML('<img src="Start.jpg">. '),"Daraufhin wird für jede weitere Stichprobe die jeweilige
Punktwolke und Regressionsgerade in der linken Grafik gezeigt. In der 
mittleren Grafik wird die Häufigkeitsverteilung der bislang erzeugten \\( 
\\hat{\\beta} \\)-Werte in einem Histogramm veranschaulicht (graue Balken). 
Die Häufigkeitsverteilung der \\( \\hat{\\alpha} \\)-Werte ist in der rechten 
Grafik zu sehen. Je mehr Stichproben hinzukommen, umso stärker nehmen die 
Histogramme die Gestalt einer Normalverteilung an. Sie können den Prozess 
mit",
HTML('<img src="Pause.jpg">'),"unterbrechen. Wenn Ihnen der Prozess zu 
langsam abläuft, können Sie den Stichproben-Schieber einfach auf \\( 100 \\)
erhöhen. Die linke Grafik zeigt dann die Punktwolke und die Regressionsgerade
der \\( 100 \\). Stichprobe an und die Histogramme in der mittleren und
rechten Grafik berücksichtigen alle \\( 100 \\) KQ-Schätzwerte.</dd></dl>"),
HTML("<dl class='dl-horizontal'> <dt><img src='Gemeinsam.jpg'></dt> <dd style ='color:black;'>Bei
dieser Darstellungsform werden die \\( S \\) Regressionsgeraden gemeinsam in
der linken Grafik angezeigt, wobei die Regressionsgerade der letzten
Stichprobe schwarz markiert ist. Die Punktwolken werden allerdings
weggelassen. Die Häufigkeitsverteilungen der KQ-Schätzwerte \\( \\hat{\\alpha}
\\) und \\( \\hat{\\beta} \\) sind auch bei dieser Darstellungsform in der
mittleren und rechten Grafik zu sehen. Wenn Sie im Bedienfenster das <img
src='Start.jpg'> Feld anklicken, werden schrittweise weitere Stichproben 
hinzugefügt.</dd></dl>"),
HTML('<p style ="color:black;">Um den Einfluss des Beobachtungsumfangs auf die 
Histogramme zu erkennen, sollten Sie im Bedienfenster den 
Beobachtungsumfang-Schieber nach rechts bewegen. Die KQ-Schätzwerte 
konzentrieren sich daraufhin enger um die wahren Werte. Der gleiche Effekt 
ergibt sich, wenn der Störgrößenvarianz-Schieber nach links bewegt wird. 
Wenn Sie bei <strong>Dichte</strong> einen Haken setzen, wird zusätzlich zum 
Histogramm eine Schätzung der Wahrscheinlichkeits(dichte)funktion vorgenommen,
also ein „geglättetes Histogramm" erzeugt.</p>'),

HTML('<p style ="color:black;">Um die aktuelle Grafik in einer jpg-Datei zu speichern, klicken Sie auf <img 
src="download.jpg">.</p>'),

HTML("<p style ='color:black;'>Um Animationen zu anderen ökonometrischen Themen zu sehen,
     klicken Sie bitte auf <img src = 'info.jpg'>.</p>"), style="color:black")),
tabPanel(h5("Details"), p("Die Animation ist mit dem statistischen
Programm R erzeugt worden. Die Dichte
der Parameter \\( \\alpha \\) und \\( \\beta \\) wurde mit Gaußkern
ermittelt. Für die Wahl der Bandbreite wurde die Faustregel von Silverman 
herangezogen (Silverman, B. W., 1986, Density Estimation for Statistics
and Data Analysis, Chapman and Hall, London, S. 47 f).",
HTML("<p style='color:black;'>Die R-Skripte für die Reproduktion
dieser Seite sind unter folgendem Link aufrufbar:
<a href='https://github.com/andronikoss/WiederholteStichproben' 
     target='_blank'>R Codes.</a></p>"), style="color:black"
))),
br(),
br(), 
br())

                       
                   
                   
            )
    ))
)  







































