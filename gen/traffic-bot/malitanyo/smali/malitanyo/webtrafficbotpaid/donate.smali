.class public Lmalitanyo/webtrafficbotpaid/donate;
.super Landroid/app/Activity;
.source "donate.java"


# instance fields
.field final context:Landroid/content/Context;

.field title:Landroid/widget/TextView;

.field wew:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 26
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Landroid/app/Activity;-><init>()V

    move-object v2, v0

    move-object v3, v0

    iput-object v3, v2, Lmalitanyo/webtrafficbotpaid/donate;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5
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

    .line 21
    move-object v3, v0

    move-object v4, v1

    invoke-super {v3, v4}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 22
    move-object v3, v0

    const/high16 v4, 0x7f030000

    invoke-virtual {v3, v4}, Lmalitanyo/webtrafficbotpaid/donate;->setContentView(I)V

    return-void
.end method
