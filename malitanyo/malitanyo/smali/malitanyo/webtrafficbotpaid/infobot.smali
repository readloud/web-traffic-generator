.class public Lmalitanyo/webtrafficbotpaid/infobot;
.super Landroid/app/Activity;
.source "infobot.java"


# instance fields
.field final context:Landroid/content/Context;

.field title:Landroid/widget/TextView;

.field wew:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 31
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Landroid/app/Activity;-><init>()V

    move-object v2, v0

    move-object v3, v0

    iput-object v3, v2, Lmalitanyo/webtrafficbotpaid/infobot;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
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

    move-object v6, v0

    const-string v7, "com.aide.ui"

    invoke-static {v6, v7}, Ladrt/ADRTLogCatReader;->onContext(Landroid/content/Context;Ljava/lang/String;)V

    .line 21
    move-object v6, v0

    move-object v7, v1

    invoke-super {v6, v7}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 22
    move-object v6, v0

    const v7, 0x7f030001

    invoke-virtual {v6, v7}, Lmalitanyo/webtrafficbotpaid/infobot;->setContentView(I)V

    .line 25
    move-object v6, v0

    invoke-virtual {v6}, Lmalitanyo/webtrafficbotpaid/infobot;->getIntent()Landroid/content/Intent;

    move-result-object v6

    const-string v7, "URL"

    invoke-virtual {v6, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 26
    move-object v6, v0

    invoke-virtual {v6}, Lmalitanyo/webtrafficbotpaid/infobot;->getIntent()Landroid/content/Intent;

    move-result-object v6

    const-string v7, "TIT"

    invoke-virtual {v6, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 27
    move-object v6, v0

    move-object v7, v0

    const v8, 0x7f070002

    invoke-virtual {v7, v8}, Lmalitanyo/webtrafficbotpaid/infobot;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/TextView;

    iput-object v7, v6, Lmalitanyo/webtrafficbotpaid/infobot;->wew:Landroid/widget/TextView;

    .line 28
    move-object v6, v0

    move-object v7, v0

    const v8, 0x7f070001

    invoke-virtual {v7, v8}, Lmalitanyo/webtrafficbotpaid/infobot;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/TextView;

    iput-object v7, v6, Lmalitanyo/webtrafficbotpaid/infobot;->title:Landroid/widget/TextView;

    .line 29
    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/infobot;->wew:Landroid/widget/TextView;

    move-object v7, v3

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 30
    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/infobot;->title:Landroid/widget/TextView;

    move-object v7, v4

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
