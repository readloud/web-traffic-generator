.class Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;
.super Ljava/lang/Object;
.source "multi.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/multi$100000005;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000004"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/multi$100000005;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;)Lmalitanyo/webtrafficbotpaid/multi$100000005;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 150
    move-object v0, p0

    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi;->context:Landroid/content/Context;

    invoke-virtual {v10}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v10

    const v11, 0x7f040004

    invoke-virtual {v10, v11}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v10

    move-object v2, v10

    .line 151
    move-object v10, v2

    new-instance v11, Ljava/util/Random;

    move-object v14, v11

    move-object v11, v14

    move-object v12, v14

    invoke-direct {v12}, Ljava/util/Random;-><init>()V

    move-object v12, v2

    array-length v12, v12

    invoke-virtual {v11, v12}, Ljava/util/Random;->nextInt(I)I

    move-result v11

    aget-object v10, v10, v11

    move-object v3, v10

    .line 154
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi;->context:Landroid/content/Context;

    invoke-virtual {v10}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v10

    const v11, 0x7f040008

    invoke-virtual {v10, v11}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v10

    move-object v4, v10

    .line 155
    move-object v10, v4

    new-instance v11, Ljava/util/Random;

    move-object v14, v11

    move-object v11, v14

    move-object v12, v14

    invoke-direct {v12}, Ljava/util/Random;-><init>()V

    move-object v12, v4

    array-length v12, v12

    invoke-virtual {v11, v12}, Ljava/util/Random;->nextInt(I)I

    move-result v11

    aget-object v10, v10, v11

    move-object v5, v10

    .line 158
    new-instance v10, Ljava/util/HashMap;

    move-object v14, v10

    move-object v10, v14

    move-object v11, v14

    invoke-direct {v11}, Ljava/util/HashMap;-><init>()V

    move-object v6, v10

    .line 159
    move-object v10, v6

    const-string v11, "Referer"

    move-object v12, v3

    invoke-interface {v10, v11, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    .line 160
    move-object v10, v5

    move-object v7, v10

    .line 161
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-virtual {v10}, Lmalitanyo/webtrafficbotpaid/multi;->getIntent()Landroid/content/Intent;

    move-result-object v10

    const-string v11, "URL"

    invoke-virtual {v10, v11}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object v8, v10

    .line 162
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    invoke-virtual {v10}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v10

    const/4 v11, 0x1

    invoke-virtual {v10, v11}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    .line 163
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    invoke-virtual {v10}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v10

    move-object v11, v7

    invoke-virtual {v10, v11}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    .line 164
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    invoke-virtual {v10}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v10

    const/4 v11, 0x1

    invoke-virtual {v10, v11}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 165
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    invoke-virtual {v10}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v10

    const/4 v11, 0x1

    invoke-virtual {v10, v11}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 166
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    invoke-virtual {v10}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v10

    const/4 v11, 0x0

    invoke-virtual {v10, v11}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 167
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    new-instance v11, Lmalitanyo/webtrafficbotpaid/multi$MyWebViewClient03;

    move-object v14, v11

    move-object v11, v14

    move-object v12, v14

    move-object v13, v0

    iget-object v13, v13, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v13}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v13

    invoke-direct {v12, v13}, Lmalitanyo/webtrafficbotpaid/multi$MyWebViewClient03;-><init>(Lmalitanyo/webtrafficbotpaid/multi;)V

    invoke-virtual {v10, v11}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 168
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi;->access$L1000004(Lmalitanyo/webtrafficbotpaid/multi;)Landroid/webkit/WebView;

    move-result-object v10

    move-object v11, v8

    move-object v12, v6

    invoke-virtual {v10, v11, v12}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;Ljava/util/Map;)V

    .line 170
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    move-object v14, v10

    move-object v10, v14

    move-object v11, v14

    iget v11, v11, Lmalitanyo/webtrafficbotpaid/multi;->counter:I

    const/4 v12, 0x1

    add-int/lit8 v11, v11, 0x1

    iput v11, v10, Lmalitanyo/webtrafficbotpaid/multi;->counter:I

    .line 171
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi;->tx1:Landroid/widget/TextView;

    move-object v11, v0

    iget-object v11, v11, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v11}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v11

    iget v11, v11, Lmalitanyo/webtrafficbotpaid/multi;->counter:I

    invoke-static {v11}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 172
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi;->tx4:Landroid/widget/TextView;

    move-object v11, v3

    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 173
    move-object v10, v0

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi$100000005$100000004;->this$0:Lmalitanyo/webtrafficbotpaid/multi$100000005;

    invoke-static {v10}, Lmalitanyo/webtrafficbotpaid/multi$100000005;->access$0(Lmalitanyo/webtrafficbotpaid/multi$100000005;)Lmalitanyo/webtrafficbotpaid/multi;

    move-result-object v10

    iget-object v10, v10, Lmalitanyo/webtrafficbotpaid/multi;->tx3:Landroid/widget/TextView;

    move-object v11, v7

    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
