.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000008"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 210
    move-object v0, p0

    move-object v1, p1

    new-instance v5, Landroid/content/Intent;

    move-object v8, v5

    move-object v5, v8

    move-object v6, v8

    const-string v7, "android.intent.action.VIEW"

    invoke-direct {v6, v7}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v3, v5

    .line 211
    move-object v5, v3

    const-string v6, "http://filezone.us/"

    invoke-static {v6}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    move-result-object v5

    .line 212
    move-object v5, v0

    iget-object v5, v5, Lmalitanyo/webtrafficbotpaid/MainActivity$100000008;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v6, v3

    invoke-virtual {v5, v6}, Lmalitanyo/webtrafficbotpaid/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
