.class public Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;
.super Ljava/lang/Object;
.source "more_app.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/more_app;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x21
    name = "WebAppInterface"
.end annotation


# instance fields
.field mContext:Landroid/content/Context;

.field private final this$0:Lmalitanyo/webtrafficbotpaid/more_app;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/more_app;Landroid/content/Context;)V
    .locals 6

    .prologue
    .line 38
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v0

    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;->this$0:Lmalitanyo/webtrafficbotpaid/more_app;

    .line 39
    move-object v4, v0

    move-object v5, v2

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;->mContext:Landroid/content/Context;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;)Lmalitanyo/webtrafficbotpaid/more_app;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;->this$0:Lmalitanyo/webtrafficbotpaid/more_app;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public showToast(Ljava/lang/String;)V
    .locals 9
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 45
    move-object v0, p0

    move-object v1, p1

    new-instance v5, Landroid/content/Intent;

    move-object v8, v5

    move-object v5, v8

    move-object v6, v8

    const-string v7, "android.intent.action.VIEW"

    invoke-direct {v6, v7}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v3, v5

    .line 46
    move-object v5, v3

    move-object v6, v1

    invoke-static {v6}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    move-result-object v5

    .line 47
    move-object v5, v0

    iget-object v5, v5, Lmalitanyo/webtrafficbotpaid/more_app$WebAppInterface;->this$0:Lmalitanyo/webtrafficbotpaid/more_app;

    move-object v6, v3

    invoke-virtual {v5, v6}, Lmalitanyo/webtrafficbotpaid/more_app;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
