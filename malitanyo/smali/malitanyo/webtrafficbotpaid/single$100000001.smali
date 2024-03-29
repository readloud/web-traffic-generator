.class Lmalitanyo/webtrafficbotpaid/single$100000001;
.super Ljava/util/TimerTask;
.source "single.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/single;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000001"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;
    }
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/single;

.field private final val$modded:Ljava/util/Timer;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/single;Ljava/util/Timer;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v0

    invoke-direct {v4}, Ljava/util/TimerTask;-><init>()V

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000001;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    move-object v4, v0

    move-object v5, v2

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000001;->val$modded:Ljava/util/Timer;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/single$100000001;)Lmalitanyo/webtrafficbotpaid/single;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/single$100000001;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 71
    move-object v0, p0

    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/single$100000001;->this$0:Lmalitanyo/webtrafficbotpaid/single;

    new-instance v3, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;

    move-object v7, v3

    move-object v3, v7

    move-object v4, v7

    move-object v5, v0

    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/single$100000001;->val$modded:Ljava/util/Timer;

    invoke-direct {v4, v5, v6}, Lmalitanyo/webtrafficbotpaid/single$100000001$100000000;-><init>(Lmalitanyo/webtrafficbotpaid/single$100000001;Ljava/util/Timer;)V

    invoke-virtual {v2, v3}, Lmalitanyo/webtrafficbotpaid/single;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
