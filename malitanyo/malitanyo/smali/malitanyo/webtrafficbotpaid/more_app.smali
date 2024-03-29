.class public Lmalitanyo/webtrafficbotpaid/more_app;
.super Landroid/app/Activity;
.source "more_app.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;,
        Lmalitanyo/webtrafficbotpaid/more_app$100000000;,
        Lmalitanyo/webtrafficbotpaid/more_app$100000001;
    }
.end annotation


# instance fields
.field final context:Landroid/content/Context;

.field private mw:Landroid/webkit/WebView;

.field title:Landroid/widget/TextView;

.field wew:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 67
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Landroid/app/Activity;-><init>()V

    move-object v2, v0

    move-object v3, v0

    iput-object v3, v2, Lmalitanyo/webtrafficbotpaid/more_app;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 53
    move-object v0, p0

    new-instance v4, Landroid/app/AlertDialog$Builder;

    move-object v9, v4

    move-object v4, v9

    move-object v5, v9

    move-object v6, v0

    invoke-direct {v5, v6}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object v2, v4

    .line 55
    move-object v4, v2

    const-string v5, "Need to Confirm"

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    .line 56
    move-object v4, v2

    const-string v5, "Are you sure you want to Close?"

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    .line 57
    move-object v4, v2

    const-string v5, "Yes"

    new-instance v6, Lmalitanyo/webtrafficbotpaid/more_app$100000000;

    move-object v9, v6

    move-object v6, v9

    move-object v7, v9

    move-object v8, v0

    invoke-direct {v7, v8}, Lmalitanyo/webtrafficbotpaid/more_app$100000000;-><init>(Lmalitanyo/webtrafficbotpaid/more_app;)V

    invoke-virtual {v4, v5, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    .line 62
    move-object v4, v2

    const-string v5, "No"

    new-instance v6, Lmalitanyo/webtrafficbotpaid/more_app$100000001;

    move-object v9, v6

    move-object v6, v9

    move-object v7, v9

    move-object v8, v0

    invoke-direct {v7, v8}, Lmalitanyo/webtrafficbotpaid/more_app$100000001;-><init>(Lmalitanyo/webtrafficbotpaid/more_app;)V

    invoke-virtual {v4, v5, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    .line 66
    move-object v4, v2

    invoke-virtual {v4}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v4

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Bundle;",
            ")V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    const-string v4, "com.aide.ui"

    invoke-static {v3, v4}, Ladrt/ADRTLogCatReader;->onContext(Landroid/content/Context;Ljava/lang/String;)V

    .line 22
    move-object v3, v0

    move-object v4, v1

    invoke-super {v3, v4}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 23
    move-object v3, v0

    const v4, 0x7f030003

    invoke-virtual {v3, v4}, Lmalitanyo/webtrafficbotpaid/more_app;->setContentView(I)V

    .line 25
    move-object v3, v0

    move-object v4, v0

    const v5, 0x7f070011

    invoke-virtual {v4, v5}, Lmalitanyo/webtrafficbotpaid/more_app;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/webkit/WebView;

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    .line 26
    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setLoadsImagesAutomatically(Z)V

    .line 27
    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 28
    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    .line 29
    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    new-instance v4, Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;

    move-object v8, v4

    move-object v4, v8

    move-object v5, v8

    move-object v6, v0

    move-object v7, v0

    invoke-direct {v5, v6, v7}, Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;-><init>(Lmalitanyo/webtrafficbotpaid/more_app;Landroid/content/Context;)V

    const-string v5, "Android"

    invoke-virtual {v3, v4, v5}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 31
    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app;->mw:Landroid/webkit/WebView;

    const-string v4, "file:///android_res/drawable/pad.html"

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method
