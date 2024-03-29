.class Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;
.super Ljava/lang/Object;
.source "single.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/single$100000001;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000000"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

.field private final val$modded:Ljava/util/Timer;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/single$100000001;Ljava/util/Timer;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v0

    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    move-object v4, v0

    move-object v5, v2

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->val$modded:Ljava/util/Timer;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;)Lmalitanyo/webtrafficbotpaid/single$100000001;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 75
    move-object/from16 v0, p0

    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->context:Landroid/content/Context;

    invoke-virtual {v12}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v12

    const v13, 0x7f040002

    invoke-virtual {v12, v13}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v12

    move-object v2, v12

    .line 76
    move-object v12, v2

    new-instance v13, Ljava/util/Random;

    move-object/from16 v16, v13

    move-object/from16 v13, v16

    move-object/from16 v14, v16

    invoke-direct {v14}, Ljava/util/Random;-><init>()V

    move-object v14, v2

    array-length v14, v14

    invoke-virtual {v13, v14}, Ljava/util/Random;->nextInt(I)I

    move-result v13

    aget-object v12, v12, v13

    move-object v3, v12

    .line 78
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->context:Landroid/content/Context;

    invoke-virtual {v12}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v12

    const v13, 0x7f040006

    invoke-virtual {v12, v13}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v12

    move-object v4, v12

    .line 79
    move-object v12, v4

    new-instance v13, Ljava/util/Random;

    move-object/from16 v16, v13

    move-object/from16 v13, v16

    move-object/from16 v14, v16

    invoke-direct {v14}, Ljava/util/Random;-><init>()V

    move-object v14, v4

    array-length v14, v14

    invoke-virtual {v13, v14}, Ljava/util/Random;->nextInt(I)I

    move-result v13

    aget-object v12, v12, v13

    move-object v5, v12

    .line 82
    new-instance v12, Ljava/util/HashMap;

    move-object/from16 v16, v12

    move-object/from16 v12, v16

    move-object/from16 v13, v16

    invoke-direct {v13}, Ljava/util/HashMap;-><init>()V

    move-object v6, v12

    .line 83
    move-object v12, v6

    const-string v13, "Referer"

    move-object v14, v3

    invoke-interface {v12, v13, v14}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    .line 84
    move-object v12, v5

    move-object v7, v12

    .line 88
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-virtual {v12}, Lmalitanyo/webtrafficbotpaid/single;->getIntent()Landroid/content/Intent;

    move-result-object v12

    const-string v13, "URL"

    invoke-virtual {v12, v13}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    move-object v8, v12

    .line 89
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    const/4 v13, 0x1

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    .line 90
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    move-object v13, v7

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    .line 91
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    const/4 v13, 0x1

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 92
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    const/4 v13, 0x1

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 93
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    const/4 v13, 0x1

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 94
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    const/4 v13, 0x1

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 95
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    invoke-virtual {v12}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v12

    const/4 v13, 0x0

    invoke-virtual {v12, v13}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 96
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    const/4 v13, 0x0

    invoke-virtual {v12, v13}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 97
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    new-instance v13, Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;

    move-object/from16 v16, v13

    move-object/from16 v13, v16

    move-object/from16 v14, v16

    move-object v15, v0

    iget-object v15, v15, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v15}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v15

    invoke-direct {v14, v15}, Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;-><init>(Lmalitanyo/webtrafficbotpaid/single;)V

    invoke-virtual {v12, v13}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 98
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single;->access$L1000000(Lmalitanyo/webtrafficbotpaid/single;)Landroid/webkit/WebView;

    move-result-object v12

    move-object v13, v8

    move-object v14, v6

    invoke-virtual {v12, v13, v14}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;Ljava/util/Map;)V

    .line 100
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    move-object/from16 v16, v12

    move-object/from16 v12, v16

    move-object/from16 v13, v16

    iget v13, v13, Lmalitanyo/webtrafficbotpaid/single;->counter:I

    const/4 v14, 0x1

    add-int/lit8 v13, v13, 0x1

    iput v13, v12, Lmalitanyo/webtrafficbotpaid/single;->counter:I

    .line 101
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->tx1:Landroid/widget/TextView;

    move-object v13, v0

    iget-object v13, v13, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v13}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v13

    iget v13, v13, Lmalitanyo/webtrafficbotpaid/single;->counter:I

    invoke-static {v13}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 102
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->tx2:Landroid/widget/TextView;

    move-object v13, v8

    invoke-virtual {v12, v13}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 103
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->tx4:Landroid/widget/TextView;

    move-object v13, v3

    invoke-virtual {v12, v13}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 104
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->tx3:Landroid/widget/TextView;

    move-object v13, v7

    invoke-virtual {v12, v13}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 105
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->tx3:Landroid/widget/TextView;

    move-object v13, v7

    invoke-virtual {v12, v13}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 106
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    invoke-virtual {v12}, Lmalitanyo/webtrafficbotpaid/single;->getIntent()Landroid/content/Intent;

    move-result-object v12

    const-string v13, "LIMIT"

    invoke-virtual {v12, v13}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    move-object v9, v12

    .line 107
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v12}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v12

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single;->tx1:Landroid/widget/TextView;

    invoke-virtual {v12}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v12

    invoke-interface {v12}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v12

    move-object v13, v9

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_1

    .line 108
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->val$modded:Ljava/util/Timer;

    if-eqz v12, :cond_0

    .line 109
    move-object v12, v0

    iget-object v12, v12, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->val$modded:Ljava/util/Timer;

    invoke-virtual {v12}, Ljava/util/Timer;->cancel()V

    .line 110
    :cond_0
    new-instance v12, Landroid/app/AlertDialog$Builder;

    move-object/from16 v16, v12

    move-object/from16 v12, v16

    move-object/from16 v13, v16

    move-object v14, v0

    iget-object v14, v14, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000001;

    invoke-static {v14}, Lmalitanyo/webtrafficbotpaid/single$100000001;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v14

    invoke-direct {v13, v14}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object v10, v12

    .line 111
    move-object v12, v10

    const v13, 0x7f050003

    invoke-virtual {v12, v13}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v12

    .line 112
    move-object v12, v10

    invoke-virtual {v12}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v12

    :cond_1
    return-void
.end method
