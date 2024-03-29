.class Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;
.super Landroid/webkit/WebChromeClient;
.source "single.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/single;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x22
    name = "MyWebViewClient"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/single;


# direct methods
.method public constructor <init>(Lmalitanyo/webtrafficbotpaid/single;)V
    .locals 5

    .prologue
    .line 177
    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Landroid/webkit/WebChromeClient;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;)Lmalitanyo/webtrafficbotpaid/single;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onProgressChanged(Landroid/webkit/WebView;I)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/webkit/WebView;",
            "I)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 173
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/single$MyWebViewClient;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    move v5, v2

    invoke-virtual {v4, v5}, Lmalitanyo/webtrafficbotpaid/single;->setValue(I)V

    .line 174
    move-object v4, v0

    move-object v5, v1

    move v6, v2

    invoke-super {v4, v5, v6}, Landroid/webkit/WebChromeClient;->onProgressChanged(Landroid/webkit/WebView;I)V

    return-void
.end method
