shinyServer(function(input, output) {
  CMD <- "python /home/tian/tensorflow/tensorflow/models/image/imagenet/classify_image.py --image_file imgPath"
  img <- "/tmp/imagenet/cropped_panda.jpg"
  
  outputtext <- reactive({
    if (!is.null(input$file1)) {img <- input$file1$datapath}
    system(gsub('imgPath', img, CMD),intern=T)
  })
  
  output$tab <- renderDataTable({
    res <- outputtext()
    df <- data.frame(Object = gsub(" *\\(.*?\\) *", "", res),
                     Score  = gsub("[^0-9.]", "", res)) 
    df$Object <- as.character(df$Object)
    df$Score <- as.numeric(as.character(df$Score))
    print(df)
    
    }, options = list(searching = 0, lengthChange = 0)) 
#   
#   output$plot <- renderPlot({
#     res <- outputtext()
#     df <- data.frame(Object = gsub(" *\\(.*?\\) *", "", res),
#                      Score  = gsub("[^0-9.]", "", res)) 
#     df$Object <- as.character(df$Object)
#     df$Score <- as.numeric(as.character(df$Score))
# #     s <- strsplit(as.character(df$Object), ' ?, ?')
# #     df <- data.frame(Object=unlist(s), Score=rep(df$Score, sapply(s, FUN=length)))
# #     df$Object <- as.character(df$Object)
#     
#     wordcloud(df$Object, df$Score, scale=c(4,2), colors=brewer.pal(6, "RdBu"),random.order=F)
#     wordcloud(df$Object, df$Score)
#     
#     
# #     ###This is to create wordcloud based on image recognition results###
# #     df <- data.frame(gsub(" *\\(.*?\\) *", "", outputtext()),gsub("[^0-9.]", "", outputtext())) #Make a dataframe using detected objects and scores
# #     names(df) <- c("Object","Score") #Set column names
# #     df$Object <- as.character(df$Object) #Convert df$Object to character
# #     df$Score <- as.numeric(as.character(df$Score)) #Convert df$Score to numeric
# #     s <- strsplit(as.character(df$Object), ',') #Split rows by comma to separate rows
# #     df <- data.frame(Object=unlist(s), Score=rep(df$Score, sapply(s, FUN=length))) #Allocate scores to split words
# #     # By separating long categories into shorter terms, we can avoid "could not be fit on page. It will not be plotted" warning as much as possible
# #     wordcloud(df$Object, df$Score, scale=c(4,2),
# #               colors=brewer.pal(6, "RdBu"),random.order=F) #Make wordcloud
#     
#     # wordcloud(c(letters, LETTERS, 0:9), seq(1, 1000, len = 62))
#   })
#   
  output$outputImage <- renderImage({
    if (!is.null(input$file1)) {img <- input$file1$datapath}
    list(src = img, contentType="image/jpg", width=300)
  }, deleteFile = TRUE)
})

