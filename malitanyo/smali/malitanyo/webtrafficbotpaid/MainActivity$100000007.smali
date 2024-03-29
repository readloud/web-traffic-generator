.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;
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
    name = "100000007"
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

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 10
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
    .line 198
    move-object v0, p0

    move-object v1, p1

    new-instance v6, Landroid/content/Intent;

    move-object v9, v6

    move-object v6, v9

    move-object v7, v9

    const-string v8, "android.intent.action.SEND"

    invoke-direct {v7, v8}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v3, v6

    .line 199
    move-object v6, v3

    const-string v7, "text/plain"

    invoke-virtual {v6, v7}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v6

    .line 200
    const-string v6, "Get more traffic in your website or blog using this useful android apps Web Traffic Bot Rebiuld for free Download here \u2192 http://play.google.com/store/apps/details?id=malitanyo.webtrafficbotpaid"

    move-object v4, v6

    .line 201
    move-object v6, v3

    const-string v7, "android.intent.extra.SUBJECT"

    const-string v8, "Web Traffic Bot Paid"

    invoke-virtual {v6, v7, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v6

    .line 202
    move-object v6, v3

    const-string v7, "android.intent.extra.TEXT"

    move-object v8, v4

    invoke-virtual {v6, v7, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v6

    .line 203
    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/MainActivity$100000007;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v7, v3

    const-string v8, "Share via"

    invoke-static {v7, v8}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v7

    invoke-virtual {v6, v7}, Lmalitanyo/webtrafficbotpaid/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
