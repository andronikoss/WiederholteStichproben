

library(shiny)

shinyUI(fluidPage(withMathJax(),
    titlePanel("Trinkgeld-Beispiel: Wiederholte Stichproben"),
    
    sidebarLayout(position="right",
                  sidebarPanel(
                      h5("Bedienfenster"),
                      sliderInput('Number.of.Observation', 'Beobachtungsumfang \\( (T) \\)',
                                  value=3, min=3, max=150, step=1,),
                      sliderInput('sigma', 'Varianz der Störgrößen \\( ({\\sigma}^2) \\)',
                                  value=2, min=0, max=10, step=0.1,),
                      div(sliderInput('pick', 'Stichproben \\( (S) \\)',
                                      value=1, min=1, max=100, step=1,
                                      animate=animationOptions(interval=1000,
                                                               playButton = HTML('<button type="button" class="btn btn-primary btn-lg">
                                                                <span class="icon-play"></span> Start </button>'),
                                                               pauseButton = HTML('<button type="button" class="btn btn-primary btn-lg">
                                                                <span class="icon-pause"></span> Pause </button>') ))),
                      
                      selectInput("select", label = "Darstellung", 
                                  choices = list("Einzeln", "Gemeinsam"), 
                                  selected = "Einzeln"),
                      checkboxInput("checkbox", label = "Dichte", value = F),
                      br(),
                      br(),
                      shinysky::actionButton('action', 'Stichprobenerzeugung', styleclass='success'),
                      downloadButton('downloadPlot', 'Grafik herunterladen'),
                      br(),
                      br(),
                      p(strong("© 2014 Grundlagen der Ökonometrie"),align = "center"),
                      p(strong("Universität Trier, Fachbereich IV - Volkswirtschaftslehre"),align = "center"),
                      p(strong(a("Professur für Finanzwissenschaft", href = "https://www.uni-trier.de/index.php?id=50126")),align = "center")
                      
                     
                     
                      
                      
                  ),
                  mainPanel(
                      plotOutput("densityPlot"),
                      tabsetPanel(type = "tabs",
                      tabPanel(h5("Was wird hier veranschaulicht?"),

                      p("Bei jeder wiederholten Stichprobe ergibt sich eine neue Punktwolke.
                        Jede neue Punktwolke liefert neue KQ-Schätzwerte \\( \\hat{\\alpha} \\)
                        und \\( \\hat{\\beta} \\).  In der Animation können Sie den Einfluss der Störgrößenvarianz
                        und des Beobachtungsumfangs auf diese KQ-Schätzwerte studieren."
                        ) ),
                      tabPanel(h5("Was zeigt die Anfangseinstellung?"),
                        p("Die Animation greift das Trinkgeld-Beispiel des Lehrbuches
                        (Auer, Ludwig von (2013), Grundlagen der Ökonometrie - eine Einführung, 6. Auflage, Springer-Gabler)
                            auf. Für jeden Gast t wird das beobachtete Trinkgeld \\( y_{t} \\) 
                        durch den Rechnungsbetrag \\( x_{t} \\) erklärt:
                         $$y_{t}=α+βx_{t}+u_{t}$$
                         
                        Der Animation sind die wahren Parameterwerte \\( \\alpha = 0,25 \\)   und  \\( \\beta =0,125 \\) 
                        sowie die Rechungsbeträge \\( x_{1}=10 \\), \\( x_{2}=30 \\) und \\( x_{3}=50 \\) zugrunde gelegt
                        . Ferner wurden normalverteilte Störgrößen \\( u_{t} \\) mit Erwartungswert
                        \\( E(u_{t})=0 \\) unterstellt. In der Anfangseinstellung beträgt die Störgrößenvarianz
                        \\( {\\sigma}^2 = 2 \\) und der Beobachtungsumfang (Anzahl der Beobachtungen pro Stichprobe,)
                        beträgt \\( T=3 \\).",
                               
                        HTML("<ul><li>Die <strong>linke Grafik</strong> zeigt die Punktwolke, welche auf der Grundlage
                        dieser Parameterwerte in einem Zufallsprozess erzeugt wurde.
                        Die rote Linie ist die resultierende KQ-Regressionsgerade.</li></ul>"),
                        HTML("<ul><li>Die blaue Gerade der <strong>mittleren Grafik</strong> markiert den \\( \\hat{\\beta} \\)-Wert (Steigung)
                          dieser Regressionsgerade, die schwarze Gerade den wahren Wert \\( \\beta = 0,125 \\) .
                          Die graue Fläche kann zunächst noch ignoriert werden.</li></ul>"),
                        HTML("<ul><li>Die blaue Gerade der <strong>rechten Grafik</strong> markiert
                        den \\( \\alpha \\)-Wert der Regressionsgerade (Schnittpunkt mit der vertikalen Achse)
                          und die schwarze Gerade den wahren Wert \\( \\alpha = 0,25 \\).</li></ul>")
                      )),

                     tabPanel(h5("Wie kann die Animation genutzt werden?"), 
                     p("Im Bedienfenster stellen Sie mit dem
                       Stichproben-Schieber ein,
                       wie viel wiederholte Stichproben \\( S \\) erzeugt werden sollen. 
                       Zu diesem Zweck klicken Sie auf den Schieber und bewegen sie
                       ihn nach rechts oder links. Jeder wiederholten Stichprobe liegen
                       die gleichen Rechnungsbeträge (\\( x_{1}=10 \\), \\( x_{2}=30 \\) und \\( x_{3}=50 \\))
                       und die gleichen Regressionsparameter ( \\( \\alpha = 0,25 \\) und \\( \\beta =0,125 \\))
                       zugrunde. Die zufallsabhängigen Störgrößen \\( u_{t} \\) sorgen dafür,
                       dass die Trinkgeldbeträge \\( y_{t} \\) in jeder wiederholten Stichprobe
                       dennoch unterschiedlich ausfallen. Es werden folglich \\( S \\)
                       verschiedene Punktwolken und damit \\( S \\) verschiedene
                       KQ-Regressionsgeraden erzeugt. Wenn Sie im Bedienfeld
                       ", HTML("<button class='btn btn-mini btn-success' type='button'>Stichprobenerzeugung</button>") ,"drücken, werden \\( S \\) neue Stichproben
                       erzeugt und die alten werden gelöscht.",
                       HTML('<p>Wie die \\( S \\) Stichproben in der linken Grafik dargestellt werden sollen,
                        legen Sie selbst fest. Im Bedienfeld haben Sie unter der Überschrift
                        "Darstellung" die Wahl zwischen <button class="btn dropdown-toggle" data-toggle="dropdown">Einzeln <span class="caret"></span></button> und
                            <button class="btn dropdown-toggle" data-toggle="dropdown">Gemeinsam <span class="caret"></span></button> Die Voreinstellung ist
                            <button class="btn dropdown-toggle" data-toggle="dropdown">Einzeln <span class="caret"></span></button></p>'),
                     HTML("<dl class='dl-horizontal'>
                        <dt><button class='btn dropdown-toggle' data-toggle='dropdown'>Einzeln <span class='caret'></span></button></dt>
                        <dd>In der linken Grafik wird die erste der \\( S \\) Stichproben einzeln dargestellt.
                          Die Grafik zeigt die Punktwolke und die Regressionsgerade dieser Stichprobe.
                          Drücken Sie nun auf", HTML('<button type="button" class="btn btn-small btn-primary"><span class="icon-play"></span> Start </button>'),"Daraufhin wird für jede weitere Stichprobe die
                          jeweilige Punktwolke und Regressionsgerade in der linken Grafik gezeigt.
                          In der mittleren Grafik wird die Häufigkeitsverteilung der bislang erzeugten
                          \\( \\hat{\\beta} \\)-Werte in einem Histogramm veranschaulicht (graue Balken).
                          Die Häufigkeitsverteilung der \\( \\hat{\\alpha} \\)-Werte ist in der rechten Grafik zu sehen.
                          Je mehr Stichproben hinzukommen, umso stärker nehmen die Histogramme die
                          Gestalt einer Normalverteilung an. Sie können den Prozess durch Anklicken)",
                          HTML('<button type="button" class="btn btn-small btn-primary"><span class="icon-pause"></span> Pause </button>'),"unterbrechen. Wenn Ihnen der Prozess zu langsam abläuft,
                          können Sie den Stichproben-Schieber einfach auf 100 erhöhen. 
                          Die linke Grafik zeigt dann die Punktwolke und die Regressionsgerade der 100.
                          Stichprobe an und die Histogramme in der mittleren und rechten
                          Grafik berücksichtigen alle 100 KQ-Schätzwerte.</dd></dl>"),
                     HTML("<dl class='dl-horizontal'>
                        <dt><button class='btn dropdown-toggle' data-toggle='dropdown'>Gemeinsam <span class='caret'></span></button></dt>
                        <dd>Bei dieser Darstellungsform werden die \\( S \\) Regressionsgeraden
                        gemeinsam in der linken Grafik angezeigt, wobei die Regressionsgerade
                        der letzten Stichprobe schwarz markiert ist.
                        Die Punktwolken werden allerdings weggelassen.
                        Die Häufigkeitsverteilungen der KQ-Schätzwerte
                        \\( \\hat{\\alpha} \\) und \\( \\hat{\\beta} \\) sind auch bei dieser Darstellungsform in der mittleren
                        und rechten Grafik zu sehen. Wenn Sie im Bedienfenster
                        das Start-Feld anklicken, werden schrittweise weitere Stichproben hinzugefügt.</dd></dl>"),
                     "Um den Einfluss des Beobachtungsumfangs auf die Histogramme zu erkennen,
                       sollten Sie im Bedienfenster den Beobachtungsumfang-Schieber nach rechts
                       bewegen. Die KQ-Schätzwerte konzentrieren sich daraufhin enger um die wahren Werte.
                       Der gleiche Effekt ergibt sich, wenn der Störgrößenvarianz-Schieber nach links bewegt wird."
                       ,
                     'Wenn Sie bei', strong("Dichte") ,'einen Haken setzen, wird zusätzlich zum Histogramm 
                       eine Schätzung der Wahrscheinlichkeits(dichte)funktion vorgenommen, also ein „geglättetes Histogramm" erzeugt.'
                       ,
                     HTML('<p>Um die aktuelle Grafik in einer jpg-Datei zu speichern, klicken Sie 
                       <button type="button" class="btn btn-default btn-lg"><span class="icon-download-alt"></span> Grafik herunterladen
                                </button> an. </p>')))),
                     br(),
                     br(),
                     br(),
                     br(),
                     br(),
                     br()
                   
                    
                       
                  )
    )
))      







































